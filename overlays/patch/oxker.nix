# FIXME: https://github.com/mrjackwills/oxker/issues/73
{
  oxker,
  ...
}:
oxker.overrideAttrs (old: {
  doCheck = false;
})
