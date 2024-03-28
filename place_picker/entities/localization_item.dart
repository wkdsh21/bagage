class LocalizationItem {
  String languageCode;
  String nearBy;
  String findingPlace;
  String noResultsFound;
  String unnamedLocation;
  String tapToSelectLocation;


  LocalizationItem({
    this.languageCode = 'kr',
    this.nearBy = 'Nearby Places',
    this.findingPlace = 'Finding place...',
    this.noResultsFound = 'No results found',
    this.unnamedLocation = 'Unnamed location',
    this.tapToSelectLocation = '도착지 설정',
  });
}
