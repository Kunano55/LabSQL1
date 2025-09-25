Create DataBase ZooDB;

Create Table AnimalType(
    animal_type_id Int Not Null,
    type_name NVarchar(100) Not Null,
    description NVarchar(MAX) Null,
    Primary Key(animal_type_id)
)

Create Table SpeciesInfo(
    species_info_id Int Not Null,
    common_name NVarchar(100) Not Null,
    scienrific_name NVarchar(100) Null,
    habitat NVarchar(MAX) Null,
    diet NVarchar(MAX) Null,
    consertion_status NVarchar(100) Null,
    description NVarchar(MAX) Null,
    Primary Key(species_info_id)
)

Create Table Enclosure(
    enclosure_id Int Not Null,
    name NVarchar(100) Not Null,
    location NVarchar(200) Null,
    Primary Key(enclosure_id)
) 

Create Table Keeper(
    keeper_id Int Not Null,
    name NVarchar(100) Not Null,
    phone NVarchar(50) Null,
    email NVarchar(100) Null,
    Primary Key(keeper_id)
)

Create Table EnclosureKeeper(
    enclosure_id Int Not Null,
    keeper_id Int Not Null,
    Primary Key(enclosure_id, keeper_id),
    Foreign Key(enclosure_id) References Enclosure(enclosure_id),
    Foreign Key(keeper_id) References Keeper(keeper_id)
)

Create Table Food(
    food_id Int Not Null,
    name NVarchar(100) Not Null,
    type NVarchar(100) Null,
    unit NVarchar(50) Null,
    Primary Key(food_id)
)

Create Table Animal(
    animal_id Int Not Null,
    anme NVarchar(100) Not Null,
    gender NVarchar(10) Null,
    birth_date Date Null,
    enclosure_id Int Null,
    animal_type_id Int Null,
    species_info_id Int Null,
    Primary Key(animal_id),
    Foreign Key(enclosure_id) References Enclosure(enclosure_id),
    Foreign Key(animal_type_id) References AnimalType(animal_type_id),
    Foreign Key(species_info_id) References SpeciesInfo(species_info_id)
)

Create Table FeedingSchule(
    feeding_id Int Not Null,
    animal_id Int Not Null,
    food_id Int Not Null,
    amount Decimal(10,2) Null,
    feeding_date Date Null,
    feedting_time Time Null,
    keeper_id Int Not Null,
    Primary Key(feeding_id),
    Foreign Key(animal_id) References Animal(animal_id),
    Foreign Key(food_id) References Food(food_id),
    Foreign Key(keeper_id) References Keeper(keeper_id)
)
