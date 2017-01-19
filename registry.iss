#ifdef StandalonePatch
  [Registry]
  Root: HKLM; Subkey: "SOFTWARE\{#RegPath}\1.0"
  Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: string; ValueName: "code"; ValueData: {#RegCode}; Flags: uninsdeletekey
  Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: string; ValueName: "installdir"; ValueData: "{app}"; Flags: uninsdeletekey
  Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: string; ValueName: "installfrom"; ValueData: ""; Flags: uninsdeletekey
    
  #ifdef LangEnglish
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_e"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_e"; ValueData: "0"; Flags: uninsdeletekey
  #endif

  #ifdef LangFrench
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_f"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_f"; ValueData: "0"; Flags: uninsdeletekey
  #endif

  #ifdef LangGerman
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_g"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_g"; ValueData: "0"; Flags: uninsdeletekey
  #endif

  #ifdef LangItalian
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_i"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_i"; ValueData: "0"; Flags: uninsdeletekey
  #endif

  #ifdef LangPolish
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_p"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_p"; ValueData: "0"; Flags: uninsdeletekey
  #endif
  
  #ifdef LangSpanish
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_s"; ValueData: "1"; Flags: uninsdeletekey
  #else
    Root: HKLM; Subkey: "SOFTWARE\{#RegPath}"; ValueType: dword; ValueName: "lang_s"; ValueData: "0"; Flags: uninsdeletekey
  #endif  
#endif