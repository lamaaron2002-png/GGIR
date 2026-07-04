# CATigraphy GGIR Patches

This bundled package is based on upstream GGIR 3.3-7 (released 2026-05-04)
and is versioned separately as 3.3-7.9004.

## Behavioural patches

- `HASPT.algo = "notused"` remains valid during parameter checking instead of
  being silently replaced by `HDCZA`.
- Actiwatch/Actiware count CSV conversion accepts CATigraphy's normalized CSV
  layout, long Actiware preambles, common activity/light column aliases, and
  blank source column names.
- The new upstream guider correction is exposed by CATigraphy as an opt-in
  first-pass validation profile. That profile uses count-compatible `HLRB`;
  the legacy profile keeps CATigraphy's existing `notused` behavior.
- `TimeSegments2ZeroFile` accepts intervals whose start or end equals the
  recording boundary, allowing manual cleaning at the beginning or end.
- `TimeSegments2ExcludeFile` is a CATigraphy extension that marks
  cursor-selected intervals as invalid protocol data instead of valid zero
  movement.
- Time-segment CSV timestamps are parsed as wall time in GGIR's `desiredtz`,
  avoiding a timezone offset when `fread` has inferred an unzoned timestamp as
  UTC.
- Upstream Parquet export remains available when the optional `arrow` package
  is installed, without making `arrow` a requirement for the normal pipeline.

## Rebase checklist

When rebasing again, verify the explicit `notused` test, count CSV conversion,
both sleep-window validation profiles, boundary segment exclusions, and
installation without `arrow`.
