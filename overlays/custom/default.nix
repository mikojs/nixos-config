final: prev:
with prev;
buildMikoRustPkgs {
  prefix = "miko-";
  config = [
    {
      name = "initialize";
      hasGenerate = false;
    }
    {
      name = "coder";
      github = {
        owner = "mikojs";
        repo = "coder";
        rev = "42665979ae3baee6dfa8482bdbc56a35b23f3bea";
        sha256 = "";
      };
      cargoHash = "";
    }
    {
      name = "db";
      github = {
        owner = "mikojs";
        repo = "db";
        rev = "34422f433a7b608891a0441a5b09adc12237d141";
        sha256 = "";
      };
      cargoHash = "";
    }
  ];
}
