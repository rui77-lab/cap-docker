/* checksum : d095aececfe885fc1e272c977d8918e7 */
@cds.external : true
function publicOdata.GetPersonWithMostFriends() returns publicOdata.People;

@cds.external : true
function publicOdata.GetNearestAirport(
  lat : Double not null,
  lon : Double not null
) returns publicOdata.Airports;

@cds.external : true
action publicOdata.ResetDataSource();

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Trip {
  key TripId : Integer not null;
  ShareId : UUID not null;
  Name : LargeString;
  @odata.Type : 'Edm.Single'
  Budget : Double not null;
  Description : LargeString;
  Tags : many LargeString;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  StartsAt : DateTime not null;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  EndsAt : DateTime not null;
  PlanItems : Association to many publicOdata.PlanItem {  };
} actions {
  function GetInvolvedPeople(
    trip : $self
  ) returns many publicOdata.People;
};

@cds.external : true
@cds.persistence.skip : true
@open : true
entity publicOdata.PlanItem {
  key PlanItemId : Integer not null;
  ConfirmationCode : LargeString;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  StartsAt : DateTime not null;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  EndsAt : DateTime not null;
  @odata.Type : 'Edm.Duration'
  Duration : String not null;
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Event : publicOdata.PlanItem {
  OccursAt : publicOdata.EventLocation;
  Description : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
@open : true
entity publicOdata.PublicTransportation : publicOdata.PlanItem {
  SeatNumber : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Flight : publicOdata.PublicTransportation {
  FlightNumber : LargeString;
  Airline : Association to one publicOdata.Airlines {  };
  ![From] : Association to one publicOdata.Airports {  };
  To : Association to one publicOdata.Airports {  };
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Employee : publicOdata.People {
  Cost : Integer64 not null;
  Peers : Association to many publicOdata.People {  };
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Manager : publicOdata.People {
  Budget : Integer64 not null;
  BossOffice : publicOdata.Location;
  DirectReports : Association to many publicOdata.People {  };
};

@cds.external : true
@open : true
type publicOdata.Location {
  Address : LargeString;
  City : publicOdata.City;
};

@cds.external : true
type publicOdata.City {
  Name : LargeString;
  CountryRegion : LargeString;
  Region : LargeString;
};

@cds.external : true
type publicOdata.AirportLocation : publicOdata.Location {
  @odata.Type : 'Edm.GeographyPoint'
  Loc : String;
};

@cds.external : true
type publicOdata.EventLocation : publicOdata.Location {
  BuildingInfo : LargeString;
};

@cds.external : true
type publicOdata.PersonGender : Integer enum {
  Male = 0;
  Female = 1;
  Unknown = 2;
};

@cds.external : true
type publicOdata.Feature : Integer enum {
  Feature1 = 0;
  Feature2 = 1;
  Feature3 = 2;
  Feature4 = 3;
};

@cds.external : true
service publicOdata {};

@cds.external : true
@cds.persistence.skip : true
@open : true
entity publicOdata.People {
  key UserName : LargeString not null;
  FirstName : LargeString not null;
  LastName : String(26);
  MiddleName : LargeString;
  Gender : publicOdata.PersonGender not null;
  Age : Integer64;
  Emails : many LargeString;
  AddressInfo : many publicOdata.Location;
  HomeAddress : publicOdata.Location;
  FavoriteFeature : publicOdata.Feature not null;
  Features : many publicOdata.Feature not null;
  Friends : Association to many publicOdata.People {  };
  BestFriend : Association to one publicOdata.People {  };
  Trips : Association to many publicOdata.Trip {  };
} actions {
  action UpdateLastName(
    person : $self,
    lastName : LargeString not null
  ) returns Boolean not null;
  action ShareTrip(
    personInstance : $self,
    userName : LargeString not null,
    tripId : Integer not null
  );
  function GetFavoriteAirline(
    person : $self
  ) returns publicOdata.Airlines;
  function GetFriendsTrips(
    person : $self,
    userName : LargeString not null
  ) returns many publicOdata.Trip;
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Airlines {
  key AirlineCode : LargeString not null;
  Name : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
entity publicOdata.Airports {
  Name : LargeString;
  key IcaoCode : LargeString not null;
  IataCode : LargeString;
  Location : publicOdata.AirportLocation;
};

@cds.external : true
@cds.persistence.skip : true
@open : true
@odata.singleton : true
entity publicOdata.Me {
  key UserName : LargeString not null;
  FirstName : LargeString not null;
  LastName : String(26);
  MiddleName : LargeString;
  Gender : publicOdata.PersonGender not null;
  Age : Integer64;
  Emails : many LargeString;
  AddressInfo : many publicOdata.Location;
  HomeAddress : publicOdata.Location;
  FavoriteFeature : publicOdata.Feature not null;
  Features : many publicOdata.Feature not null;
  Friends : Association to many publicOdata.People {  };
  BestFriend : Association to one publicOdata.People {  };
  Trips : Association to many publicOdata.Trip {  };
} actions {
  action UpdateLastName(
    person : $self,
    lastName : LargeString not null
  ) returns Boolean not null;
  action ShareTrip(
    personInstance : $self,
    userName : LargeString not null,
    tripId : Integer not null
  );
  function GetFavoriteAirline(
    person : $self
  ) returns publicOdata.Airlines;
  function GetFriendsTrips(
    person : $self,
    userName : LargeString not null
  ) returns many publicOdata.Trip;
};

