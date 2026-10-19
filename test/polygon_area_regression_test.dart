import 'package:geodesy/geodesy.dart';
import 'package:test/test.dart';

void main() {
  const square = [LatLng(0, 0), LatLng(0, 1), LatLng(1, 1), LatLng(1, 0)];
  const hole = [
    LatLng(.25, .25),
    LatLng(.25, .75),
    LatLng(.75, .75),
    LatLng(.75, .25)
  ];
  // Independent spherical-excess fixtures, calculated with l'Huilier's
  // theorem and R = 6,371,000 m (great-circle edges, not parallels).
  const squareArea = 12363997753.67991;
  const holeArea = 3090970032.258077;

  for (final useWrapper in [false, true]) {
    group(useWrapper ? 'Geodesy polygon APIs' : 'Static polygon APIs', () {
      final area = useWrapper
          ? Geodesy().calculatePolygonArea
          : PolygonArea.calculatePolygonArea;
      final areaWithHoles = useWrapper
          ? Geodesy().calculatePolygonWithHolesArea
          : PolygonHole.calculatePolygonWithHolesArea;

      test('one-degree square returns square meters', () {
        expect(area(square), closeTo(squareArea, .01));
      });

      test('octant triangle is exactly one eighth of the sphere', () {
        expect(
            area(
                [const LatLng(0, 0), const LatLng(0, 90), const LatLng(90, 0)]),
            closeTo(pi / 2 * 6371000 * 6371000, 1));
      });

      test('small polygons retain sub-square-meter precision', () {
        expect(
            area([
              const LatLng(0, 0),
              const LatLng(0, .00001),
              const LatLng(.00001, .00001),
              const LatLng(.00001, 0)
            ]),
            closeTo(1.236431171148877, 1e-6));
      });

      test('area reflects latitude', () {
        expect(
            area([
              const LatLng(60, 0),
              const LatLng(60, 1),
              const LatLng(61, 1),
              const LatLng(61, 0)
            ]),
            closeTo(6088204459.046905, .01));
      });

      test('dateline crossing uses short great-circle edges', () {
        expect(
            area([
              const LatLng(0, 179.5),
              const LatLng(0, -179.5),
              const LatLng(1, -179.5),
              const LatLng(1, 179.5)
            ]),
            closeTo(squareArea, .01));
      });

      test('polygon enclosing a pole returns the small polar area', () {
        expect(
            area([
              const LatLng(80, 0),
              const LatLng(80, 120),
              const LatLng(80, -120)
            ]),
            closeTo(1620539190892.5107, 1));
      });

      test('hemisphere with antipodal diagonals has finite area', () {
        final ring = [
          const LatLng(0, 0),
          const LatLng(0, 90),
          const LatLng(0, 180),
          const LatLng(0, -90)
        ];
        expect(area(ring), closeTo(2 * pi * 6371000 * 6371000, 1));
        expect(area(ring.reversed.toList()), closeTo(area(ring), 1));
      });

      test('orientation, starting vertex, closure and duplicates preserve area',
          () {
        for (final ring in [
          square.reversed.toList(),
          [...square.skip(1), square.first],
          [...square, square.first],
          [square.first, ...square],
        ]) {
          expect(area(ring), closeTo(squareArea, .01));
        }
      });

      test('concave polygon equals its non-overlapping triangle pieces', () {
        const a = LatLng(0, 0), b = LatLng(0, 2), c = LatLng(2, 2);
        const d = LatLng(.5, 1), e = LatLng(2, 0);
        final expected = area([a, b, d]) + area([b, c, d]) + area([a, d, e]);
        expect(area([a, b, c, d, e]), closeTo(expected, .01));
        expect(area([e, d, c, b, a]), closeTo(expected, .01));
      });

      test('empty, short and degenerate rings have zero area', () {
        for (final ring in <List<LatLng>>[
          [],
          [square.first],
          square.take(2).toList(),
          [square.first, square.first, square.first],
          [const LatLng(0, 0), const LatLng(0, 1), const LatLng(0, 2)],
        ]) {
          expect(area(ring), 0);
        }
      });

      test('invalid coordinates and antipodal edges are rejected', () {
        for (final point in [
          const LatLng(double.nan, 0),
          const LatLng(0, double.infinity),
          const LatLng(91, 0),
          const LatLng(0, 181)
        ]) {
          expect(() => area([point, ...square]), throwsArgumentError);
        }
        expect(
            () => area([
                  const LatLng(0, 0),
                  const LatLng(0, 180),
                  const LatLng(10, 90)
                ]),
            throwsArgumentError);
      });

      test('no holes returns outer area, including empty outer ring', () {
        expect(areaWithHoles(square, []), closeTo(squareArea, .01));
        expect(areaWithHoles([], []), 0);
      });

      test('subtracts spherical hole area regardless of either winding', () {
        for (final outer in [square, square.reversed.toList()]) {
          for (final inner in [hole, hole.reversed.toList()]) {
            expect(areaWithHoles(outer, [inner]),
                closeTo(squareArea - holeArea, .01));
          }
        }
      });

      test('multiple holes subtract independently of order and closure', () {
        const other = [
          LatLng(.05, .05),
          LatLng(.05, .15),
          LatLng(.15, .15),
          LatLng(.15, .05)
        ];
        final expected = squareArea - holeArea - area(other);
        expect(areaWithHoles(square, [hole, other]), closeTo(expected, .01));
        expect(
            areaWithHoles([
              ...square,
              square.first
            ], [
              [...other, other.first],
              [...hole.reversed, hole.last]
            ]),
            closeTo(expected, .01));
      });

      test('degenerate holes contribute zero and equal rings cancel', () {
        expect(
            areaWithHoles(square, [
              [],
              [square.first]
            ]),
            closeTo(squareArea, .01));
        expect(areaWithHoles(square, [square]), 0);
        expect(
            areaWithHoles(square, [square.reversed.toList()]), closeTo(0, .01));
      });

      test('holes crossing the dateline use the same spherical calculation',
          () {
        List<LatLng> shift(List<LatLng> ring) => ring
            .map((p) =>
                LatLng(p.latitude, (p.longitude + 179.5 + 180) % 360 - 180))
            .toList();
        expect(areaWithHoles(shift(square), [shift(hole)]),
            closeTo(squareArea - holeArea, .01));
      });

      test('excess hole area is rejected instead of made positive', () {
        expect(() => areaWithHoles(hole, [square]), throwsArgumentError);
        expect(() => areaWithHoles([], [square]), throwsArgumentError);
      });

      test('does not mutate input rings', () {
        expect(
            areaWithHoles(List.unmodifiable(square),
                List.unmodifiable([List<LatLng>.unmodifiable(hole)])),
            closeTo(squareArea - holeArea, .01));
      });
    });
  }
}
