import 'dart:math';

import './RandomInteger.dart';
import './RandomString.dart';
import './RandomBoolean.dart';


/// Random generator for various text values like names, addresses or phone numbers.

/// ### Example ###

///     var value1 = RandomText.name();     // Possible result: 'Segio'
///     var value2 = RandomText.verb();      // Possible result: 'Run'
///     var value3 = RandomText.Text(50);    // Possible result: 'Run jorge. Red high scream?'
 
class RandomText {
  static var _namePrefixes = ['Dr.', 'Mr.', 'Mrs'];
  static var _nameSuffixes = ['Jr.', 'Sr.', 'II', 'III'];
  static var _firstNames = [
    'John',
    'Bill',
    'Andrew',
    'Nick',
    'Pamela',
    'Bela',
    'Sergio',
    'George',
    'Hurry',
    'Cecilia',
    'Vesta',
    'Terry',
    'Patrick'
  ];
  static var _lastNames = [
    'Doe',
    'Smith',
    'Johns',
    'Gates',
    'Carmack',
    'Zontak',
    'Clinton',
    'Adams',
    'First',
    'Lopez',
    'Due',
    'White',
    'Black'
  ];
  static var _colors = [
    'Black',
    'White',
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Purple',
    'Grey',
    'Magenta',
    'Cian'
  ];
  static var _stuffs = [
    'Game',
    'Ball',
    'Home',
    'Board',
    'Car',
    'Plane',
    'Hotel',
    'Wine',
    'Pants',
    'Boots',
    'Table',
    'Chair'
  ];
  static var _adjectives = [
    'Large',
    'Small',
    'High',
    'Low',
    'Certain',
    'Fuzzy',
    'Modern',
    'Faster',
    'Slower'
  ];
  static var _verbs = [
    'Run',
    'Stay',
    'Breeze',
    'Fly',
    'Lay',
    'Write',
    'Draw',
    'Scream'
  ];
  // static var _streetTypes = [
  //     'Lane', 'Court', 'Circle', 'Drive', 'Way', 'Loop', 'Blvd', 'Street'
  // ];
  // static var _streetPrefix = [
  //     'North', 'South', 'East', 'West', 'Old', 'New', 'N.', 'S.', 'E.', 'W.'
  // ];
  // static var _streetNames = [
  //     '1st', '2nd', '3rd', '4th', '53rd', '6th', '8th', 'Acacia', 'Academy', 'Adams', 'Addison', 'Airport', 'Albany', 'Alderwood', 'Alton', 'Amerige', 'Amherst', 'Anderson',
  //     'Ann', 'Annadale', 'Applegate', 'Arcadia', 'Arch', 'Argyle', 'Arlington', 'Armstrong', 'Arnold', 'Arrowhead', 'Aspen', 'Augusta', 'Baker', 'Bald Hill', 'Bank', 'Bay Meadows',
  //     'Bay', 'Bayberry', 'Bayport', 'Beach', 'Beaver Ridge', 'Bedford', 'Beech', 'Beechwood', 'Belmont', 'Berkshire', 'Big Rock Cove', 'Birch Hill', 'Birchpond', 'Birchwood',
  //     'Bishop', 'Blackburn', 'Blue Spring', 'Bohemia', 'Border', 'Boston', 'Bow Ridge', 'Bowman', 'Bradford', 'Brandywine', 'Brewery', 'Briarwood', 'Brickell', 'Brickyard',
  //     'Bridge', 'Bridgeton', 'Bridle', 'Broad', 'Brookside', 'Brown', 'Buckingham', 'Buttonwood', 'Cambridge', 'Campfire', 'Canal', 'Canterbury', 'Cardinal', 'Carpenter',
  //     'Carriage', 'Carson', 'Catherine', 'Cedar Swamp', 'Cedar', 'Cedarwood', 'Cemetery', 'Center', 'Central', 'Chapel', 'Charles', 'Cherry Hill', 'Chestnut', 'Church', 'Circle',
  //     'Clark', 'Clay', 'Cleveland', 'Clinton', 'Cobblestone', 'Coffee', 'College', 'Colonial', 'Columbia', 'Cooper', 'Corona', 'Cottage', 'Country Club', 'Country', 'County', 'Court',
  //     'Courtland', 'Creek', 'Creekside', 'Crescent', 'Cross', 'Cypress', 'Deerfield', 'Del Monte', 'Delaware', 'Depot', 'Devon', 'Devonshire', 'Division', 'Dogwood', 'Dunbar',
  //     'Durham', 'Eagle', 'East', 'Edgefield', 'Edgemont', 'Edgewater', 'Edgewood', 'El Dorado', 'Elizabeth', 'Elm', 'Essex', 'Euclid', 'Evergreen', 'Fairfield', 'Fairground', 'Fairview',
  //     'Fairway', 'Fawn', 'Fifth', 'Fordham', 'Forest', 'Foster', 'Foxrun', 'Franklin', 'Fremont', 'Front', 'Fulton', 'Galvin', 'Garden', 'Gartner', 'Gates', 'George', 'Glen Creek',
  //     'Glen Eagles', 'Glen Ridge', 'Glendale', 'Glenlake', 'Glenridge', 'Glenwood', 'Golden Star', 'Goldfield', 'Golf', 'Gonzales', 'Grand', 'Grandrose', 'Grant', 'Green Hill',
  //     'Green Lake', 'Green', 'Greenrose', 'Greenview', 'Gregory', 'Griffin', 'Grove', 'Halifax', 'Hamilton', 'Hanover', 'Harrison', 'Hartford', 'Harvard', 'Harvey', 'Hawthorne',
  //     'Heather', 'Henry Smith', 'Heritage', 'High Noon', 'High Point', 'High', 'Highland', 'Hill Field', 'Hillcrest', 'Hilldale', 'Hillside', 'Hilltop', 'Holly', 'Homestead',
  //     'Homewood', 'Honey Creek', 'Howard', 'Indian Spring', 'Indian Summer', 'Iroquois', 'Jackson', 'James', 'Jefferson', 'Jennings', 'Jockey Hollow', 'John', 'Johnson', 'Jones',
  //     'Joy Ridge', 'King', 'Kingston', 'Kirkland', 'La Sierra', 'Lafayette', 'Lake Forest', 'Lake', 'Lakeshore', 'Lakeview', 'Lancaster', 'Lane', 'Laurel', 'Leatherwood', 'Lees Creek',
  //     'Leeton Ridge', 'Lexington', 'Liberty', 'Lilac', 'Lincoln', 'Linda', 'Littleton', 'Livingston', 'Locust', 'Longbranch', 'Lookout', 'Lower River', 'Lyme', 'Madison', 'Maiden',
  //     'Main', 'Mammoth', 'Manchester', 'Manhattan', 'Manor Station', 'Maple', 'Marconi', 'Market', 'Marsh', 'Marshall', 'Marvon', 'Mayfair', 'Mayfield', 'Mayflower', 'Meadow',
  //     'Meadowbrook', 'Mechanic', 'Middle River', 'Miles', 'Mill Pond', 'Miller', 'Monroe', 'Morris', 'Mountainview', 'Mulberry', 'Myrtle', 'Newbridge', 'Newcastle', 'Newport',
  //     'Nichols', 'Nicolls', 'North', 'Nut Swamp', 'Oak Meadow', 'Oak Valley', 'Oak', 'Oakland', 'Oakwood', 'Ocean', 'Ohio', 'Oklahoma', 'Olive', 'Orange', 'Orchard', 'Overlook',
  //     'Pacific', 'Paris Hill', 'Park', 'Parker', 'Pawnee', 'Peachtree', 'Pearl', 'Peg Shop', 'Pendergast', 'Peninsula', 'Penn', 'Pennington', 'Pennsylvania', 'Pheasant', 'Philmont',
  //     'Pierce', 'Pin Oak', 'Pine', 'Pineknoll', 'Piper', 'Plumb Branch', 'Poor House', 'Prairie', 'Primrose', 'Prince', 'Princess', 'Princeton', 'Proctor', 'Prospect', 'Pulaski',
  //     'Pumpkin Hill', 'Purple Finch', 'Queen', 'Race', 'Ramblewood', 'Redwood', 'Ridge', 'Ridgewood', 'River', 'Riverside', 'Riverview', 'Roberts', 'Rock Creek', 'Rock Maple',
  //     'Rockaway', 'Rockcrest', 'Rockland', 'Rockledge', 'Rockville', 'Rockwell', 'Rocky River', 'Roosevelt', 'Rose', 'Rosewood', 'Ryan', 'Saddle', 'Sage', 'San Carlos', 'San Juan',
  //     'San Pablo', 'Santa Clara', 'Saxon', 'School', 'Schoolhouse', 'Second', 'Shadow Brook', 'Shady', 'Sheffield', 'Sherman', 'Sherwood', 'Shipley', 'Shub Farm', 'Sierra',
  //     'Silver Spear', 'Sleepy Hollow', 'Smith Store', 'Smoky Hollow', 'Snake Hill', 'Southampton', 'Spring', 'Spruce', 'Squaw Creek', 'St Louis', 'St Margarets', 'St Paul', 'State',
  //     'Stillwater', 'Strawberry', 'Studebaker', 'Sugar', 'Sulphur Springs', 'Summerhouse', 'Summit', 'Sunbeam', 'Sunnyslope', 'Sunset', 'Surrey', 'Sutor', 'Swanson', 'Sycamore',
  //     'Tailwater', 'Talbot', 'Tallwood', 'Tanglewood', 'Tarkiln Hill', 'Taylor', 'Thatcher', 'Third', 'Thomas', 'Thompson', 'Thorne', 'Tower', 'Trenton', 'Trusel', 'Tunnel',
  //     'University', 'Vale', 'Valley Farms', 'Valley View', 'Valley', 'Van Dyke', 'Vermont', 'Vernon', 'Victoria', 'Vine', 'Virginia', 'Wagon', 'Wall', 'Walnutwood', 'Warren',
  //     'Washington', 'Water', 'Wayne', 'Westminster', 'Westport', 'White', 'Whitemarsh', 'Wild Rose', 'William', 'Williams', 'Wilson', 'Winchester', 'Windfall', 'Winding Way',
  //     'Winding', 'Windsor', 'Wintergreen', 'Wood', 'Woodland', 'Woodside', 'Woodsman', 'Wrangler', 'York',
  // ];

  static var _allWords =
      _firstNames + _lastNames + _colors + _stuffs + _adjectives + _verbs;

  
    /// Generates a random color name.
    /// The result value is capitalized.
    
    /// Returns a random color name.
     
  static String color() {
    return RandomString.pick(_colors);
  }

  
    /// Generates a random noun.
    /// The result value is capitalized.
    
    /// Returns a random noun.
     
  static String noun() {
    return RandomString.pick(_stuffs);
  }

  
    /// Generates a random adjective.
    /// The result value is capitalized.
    
    /// Returns a random adjective.
     
  static String adjective() {
    return RandomString.pick(_adjectives);
  }

  
    /// Generates a random verb.
    /// The result value is capitalized.
    
    /// Returns a random verb.
     
  static String verb() {
    return RandomString.pick(_verbs);
  }

  
    /// Generates a random phrase which consists of few words separated by spaces.
    /// The first word is capitalized, others are not.
    
    /// - [minLength]     (optional) minimum string length.
    /// - [maxLength]     maximum string length.
    /// Returns a random phrase.
     
  static String phrase(int minLength, [int maxLength = null]) {
    maxLength = max(minLength, maxLength ?? minLength);
    var size = RandomInteger.nextInteger(minLength, maxLength);
    if (size <= 0) return '';

    var result = '';
    result += RandomString.pick(RandomText._allWords);
    while (result.length < size) {
      result += ' ' + RandomString.pick(RandomText._allWords).toLowerCase();
    }

    return result;
  }

  
    /// Generates a random person's name which has the following structure
    /// <optional prefix> <first name> <second name> <optional suffix>
    
    /// Returns a random name.
     
  static String fullName() {
    var result = '';

    if (RandomBoolean.chance(3, 5))
      result += RandomString.pick(RandomText._namePrefixes) + ' ';

    result += RandomString.pick(RandomText._firstNames) +
        ' ' +
        RandomString.pick(RandomText._lastNames);

    if (RandomBoolean.chance(5, 10))
      result += ' ' + RandomString.pick(RandomText._nameSuffixes);

    return result;
  }

  
    /// Generates a random word from available first names, last names, colors, stuffs, adjectives, or verbs.
    
    /// Returns a random word.
     
  static String word() {
    return RandomString.pick(RandomText._allWords);
  }

  
    /// Generates a random text that consists of random number of random words separated by spaces.
    
    /// - [min]   (optional) a minimum number of words.
    /// - [max]   a maximum number of words.
    /// Returns     a random text.
     
  static String words(int min, [int max = null]) {
    var result = '';

    var count = RandomInteger.nextInteger(min, max ?? min);
    for (var i = 0; i < count; i++) {
      if (i > 0) result += ' ';
      result += RandomString.pick(RandomText._allWords);
    }

    return result;
  }

  
    /// Generates a random phone number.
    /// The phone number has the format: (XXX) XXX-YYYY
    
    /// Returns a random phone number.
     
  static String phone() {
    var result = '';

    result += '(' +
        RandomInteger.nextInteger(111, 999).toString() +
        ') ' +
        RandomInteger.nextInteger(111, 999).toString() +
        '-' +
        RandomInteger.nextInteger(0, 9999).toString();

    return result;
  }

  
    /// Generates a random email address.
    
    /// Returns a random email address.
     
  static String email() {
    return words(2, 6) + '@' + words(1, 3) + '.com';
  }

  
    /// Generates a random text, consisting of first names, last names, colors, stuffs, adjectives, verbs, and punctuation marks.
    
    /// - [minLength]   minimum amount of words to generate. Text will contain 'minSize' words if 'maxSize' is omitted.
    /// - [maxLength]   (optional) maximum amount of words to generate.
    /// Returns         a random text.
     
  static String text(int minLength, [int maxLength = null]) {
    maxLength = max(minLength, maxLength ?? minLength);
    var size = RandomInteger.nextInteger(minLength, maxLength);

    var result = '';
    result += RandomString.pick(RandomText._allWords);

    while (result.length < size) {
      var next = RandomString.pick(RandomText._allWords);
      if (RandomBoolean.chance(4, 6))
        next = ' ' + next.toLowerCase();
      else if (RandomBoolean.chance(2, 5))
        next = RandomString.pickChar(':,-') + next.toLowerCase();
      else if (RandomBoolean.chance(3, 5))
        next = RandomString.pickChar(':,-') + ' ' + next.toLowerCase();
      else
        next = RandomString.pickChar('.!?') + ' ' + next;

      result += next;
    }

    return result;
  }
}
