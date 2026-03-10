final: prev:
with prev;
buildMikoRustPkgs {
  prefix = "miko";
  config = [
    {
      name = "initialize";
      shouldInit = true;
      skipGenerate = true;
    }
  ];
}
