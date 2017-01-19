[Icons]
#ifdef PatchIcon
  Name: "{group}\Play Patch"; Filename: "{app}\PES6.exe"; WorkingDir: "{app}"; Comment: "Play PES6 Patch: {#PatchName}"; IconFileName: "{app}\icon\{#PatchIcon}"; Check: CheckError
  Name: "{commondesktop}\{#PatchName}"; Filename: "{app}\PES6.exe"; WorkingDir:"{app}"; Comment: "Play PES6 Patch: {#PatchName}"; IconFilename: "{app}\icon\{#PatchIcon}"; Check: CheckError
#else
  Name: "{group}\Play Patch"; Filename: "{app}\PES6.exe"; WorkingDir: "{app}"; Comment: "Play PES6 Patch: {#PatchName}"; Check: CheckError
  Name: "{commondesktop}\{#PatchName}"; Filename: "{app}\PES6.exe"; WorkingDir:"{app}"; Comment: "Play PES6 Patch: {#PatchName}"; Check: CheckError
#endif
Name: "{group}\Uninstall Patch"; Filename: "{app}\uninstall\{uninstallexe}"; WorkingDir: "{app}\uninstall"; Comment: "Uninstall PES6 Patch: {#PatchName}"; Check: CheckError
Name: "{group}\Settings Patch"; Filename: "{app}\settings.exe"; WorkingDir: "{app}"; Comment: "Settings PES6 Patch: {#PatchName}"; Check: CheckError
Name: "{commondesktop}\{#PatchName}"; Filename: "{app}\PES6.exe"; WorkingDir:"{app}"; IconFilename: "{app}\icon\icon.ico"; Comment: "Play PES6 Patch: {#PatchName}"; Check: CheckError