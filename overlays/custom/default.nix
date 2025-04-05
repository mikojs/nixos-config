final: prev: with prev; {
  initialize = callPackage ./initialize { };
  db = callPackage ./db { };
}
