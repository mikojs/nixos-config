# FIXME: oxker has testing problem in Mac
{
  oxker,
  ...
}:
oxker.overrideAttrs (old: {
  doCheck = false;
})
