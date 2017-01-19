;-----------------------------------------------------------------------------;
;                                                                             ;
;   Name:         Installer: PES 6 Patch                                      ;
;   Type:         Inno Setup Script | Open Source                             ;
;   Date:         20 January 2016                                             ;
;   Version:      1.1.0.0                                                     ;
;   License:      http://creativecommons.org/licenses/by-nc-sa/4.0/           ;
;   Website:      www.github.com/jasarsoft/p6pinstaller                       ;
;   Contact:      edinjasar14@gmail.com                                       ;
;   Developer:    Edin Jašareviæ                                              ;
;                                                                             ;
;   This code is not designed to violate someone's copyright, and does not    ;
;   allow it to be used for the same. Use of this code in part or completely  ;
;   with the changes as an individual or organization the author disclaims    ;
;   all liability for damages of users.                                       ;
;                                                                             ;
;   Copyright(c) 2005 Pro Evolution Soccer 6 by KONAMI                        ;
;   Copyright(c) 2016 PES 6 Patch Installer by Edin Jašareviæ                 ;
;                                                                             ;
;-----------------------------------------------------------------------------;


;//--- Main Settings -------------------------------------------------------\\;
;//
#define StandalonePatch

;//--- Patch Information ---------------------------------------------------\\;
#define PatchName "Patch Name"
#define PatchType "PES6 Standalone Patch"
#define PatchYear "2015"
#define PatchSeason "2014/2015"
#define PatchAuthor "Patch TM"
#define PatchLanguage "English"

#define PatchIcon "icon.ico"
#define PatchImage "img180x314.bmp"
#define PatchTopImage "img250x58.bmp"
;//Patch license and readme file;
#define PatchLicense "license.txt"
#define PatchReadme "readme.rtf"

;Value in bayte!!!
#define PatchSize 1024

;//--- Kitserver Information -----------------------------------------------\\;
#define KitserverSize 1024
#define KitserverBallsSize 1024
#define KitserverBootsSize 1024
#define KitserverFacesSize 1024
#define KitserverHairSize 1024
#define KitserverStadiumsSize 1024
#define KitserverUniSize 1024

;//--- Gameplay (Option File) ----------------------------------------------\\;
;#define Gameplay1 "Normal Patch Gameplay"
;#define Gameplay2 ""
;#define Gameplay3 ""


;//--- Language Information ------------------------------------------------\\;
;//Uncomment the correct langauge patch one or more of them.
;//One language should be uncommented that is included.
#ifdef StandalonePatch
  #define LangEnglish 1024
  ;#define LangFrench
  ;#define LangGerman  
  ;#define LangItalian  
  ;#define LangPolish
  ;#define LangSpanish
#endif

;//--- Registry Information ------------------------------------------------\\;
;//This information be edited only for stanalone versions of the patch.
;//In this case it is necessary for the application of PES is properly changed.
#ifdef StandalonePatch
  #define RegPath "KONAMIPES6\PES6"
  #define RegCode "XXXXXXXXXXXXXXXXXXXX"
#endif
;--------------------------------

; The following parameters are not required, just put in a comment to the  exclusion.
#define PatchID "7032F904-4314-4BD5-A3F5-351C6BB1C7B7"
#define PatchVersion "1.1.0.0"
;#define PatchLanguage2 "German"
;#define PatchLangauge3 "Italian"
;#define PatchLanguage4 "French"
;#define PatchLangauge5 "Polish"
;#define PatchDirInstall "Patch Name"
;#define PatchDirStartMenu "Patch Name"





#define SizeByte "1048576"
#define Version "1.1.0.0"
#define Developer "FIREBIRD TEAM"
#define Language "English"
#define Description "No requirements for PES 6 pre-installed."


#include "setup.iss"
#include "icon.iss"
#include "registry.iss"
#include "components.iss"
#include "tasks.iss"
#include "run.iss"
#include "files.iss"
#include "language.iss"
#include "message.iss"
#include "uninstall.iss"
#include "code.iss"