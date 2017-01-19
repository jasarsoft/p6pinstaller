;SECTION: COMPONENTS -------------------------------------------------------\\;
[Components]
Name: "main"; Description: "Main patch files"; Flags: fixed
#ifdef StandalonePatch
  #ifdef LangEnglish
    Name: "main\english"; Description: "Language English patch files"; ExtraDiskSpaceRequired: {#LangEnglish}; Flags: checkablealone
  #endif

#endif


;kitserver
Name: "kitserver"; Description: "Kitserver patch files"; ExtraDiskSpaceRequired: {#KitserverSize}; Flags: checkablealone
Name: "kitserver\balls"; Description: "Balls patch files"; ExtraDiskSpaceRequired: {#KitserverBallsSize}; Flags: checkablealone
Name: "kitserver\boots"; Description: "Boots patch files"; ExtraDiskSpaceRequired: {#KitserverBootsSize}; Flags: checkablealone
Name: "kitserver\faces"; Description: "Faces patch files"; ExtraDiskSpaceRequired: {#KitserverFacesSize}; Flags: checkablealone
Name: "kitserver\hair"; Description: "Hair patch files"; ExtraDiskSpaceRequired: {#KitserverHairSize}; Flags: checkablealone
Name: "kitserver\stadiums"; Description: "Stadiums patch files"; ExtraDiskSpaceRequired: {#KitserverStadiumsSize}; Flags: checkablealone
Name: "kitserver\uni"; Description: "Uni patch files"; ExtraDiskSpaceRequired: {#KitserverUniSize}; Flags: checkablealone
;//Gameplay (Option File)
#ifdef Gameplay1
  Name: "gameplay"; Description: "Gameplay patch file(s)"; Flags: fixed
  Name: "gameplay\of1"; Description: {#Gameplay1}; Flags: exclusive  
  #ifdef Gameplay2
    Name: "gameplay\of2"; Description: {#Gameplay2}; Flags: exclusive
    #ifdef Gameplay3
      Name: "gameplay\of3"; Description: {#Gameplay3}; Flags: exclusive
    #endif
  #endif
#endif