;//SECTION: FILES ----------------------------------------------------------\\;
[Files]
Source: "include\*"; DestDir: {tmp}; Flags: dontcopy
;//Icon file
#ifdef PatchIcon
Source: "icon\{#PatchIcon}"; DestDir: "{app}\icon\{#PatchIcon}"; Flags: ignoreversion
#endif

;//Gameplay (Option File)
#ifdef Gameplay1
  Source: "gameplay\1\KONAMI-WIN32PES6OPT"; DestDir: "{userdocs}\KONAMI\Pro Evolution Soccer 6\save\folder1"; Components:"gameplay\of1";Flags: ignoreversion
#endif