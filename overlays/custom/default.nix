final: prev: with prev; {
  miko-initialize = callPackage ./initialize { };
  miko-db = callPackage ./db { };
  miko-coder = callPackage ./coder { };

  miko-fish.interactiveShellInit = ''
    # Initialize
    if type -q initialize
      initialize
    end

    # db
    if type -q db
      db --generate fish | source
    end

    # coder
    if type -q coder
      coder --generate fish | source
    end
  '';
}
