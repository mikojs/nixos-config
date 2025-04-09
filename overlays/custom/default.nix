final: prev: with prev; {
  miko-initialize = callPackage ./initialize { };
  miko-db = callPackage ./db { };
}
