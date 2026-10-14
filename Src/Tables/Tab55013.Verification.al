table 55013 Verification
{
    Caption = 'Verification';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Verification No."; Code[10])
        {
            Caption = 'Verification No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Verification Time"; Time)
        {
            Caption = 'Verification Time';
            DataClassification = ToBeClassified;
        }
        field(5; "Container No./Chassis No."; Code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
        }
        field(6; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        // field(8; "Container Size"; Enum ContainerSizeEnum)
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        // }
        field(8; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(9; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Verification Type"; enum "Verification TypeEnum")
        {
            Caption = 'Verification Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Verification Notes"; Text[30])
        {
            Caption = 'Verification Notes';
            DataClassification = ToBeClassified;
        }
        field(12; "Shipper Seal"; Text[30])
        {
            Caption = 'Shipper Seal';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "No.Series"; Code[30])
        {
            Caption = 'No.series';
            DataClassification = ToBeClassified;
        }
        field(14; Verified; Boolean)
        {
            Caption = 'Verified';
            DataClassification = ToBeClassified;
        }
        field(15; "Job File No."; code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Manifest Line";
        }
        field(16; "Manifest Line No."; Integer)
        {
            Caption = 'Manifest Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(18; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(19; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(41; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(42; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(43; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(44; "New Seal"; Text[100])
        {
            Caption = 'New Seal';
            DataClassification = ToBeClassified;
        }
        field(45; "Wash Type"; Option)
        {
            OptionMembers = ,Cold,Steam;
        }
        field(46; "Repair Type"; Option)
        {
            OptionMembers = ,Minor,Medium,Major;
        }
        field(47; "Repair Time"; Time)
        {
            Caption = 'Repair Time';
            DataClassification = ToBeClassified;
        }
        field(48; "Repair Date"; Date)
        {
            Caption = 'Repair Date';
            DataClassification = ToBeClassified;
        }
        field(49; "Wash Time"; Time)
        {
            Caption = 'Wash Time';
            DataClassification = ToBeClassified;
        }
        field(50; "Wash Date"; Date)
        {
            Caption = 'Wash Date';
            DataClassification = ToBeClassified;
        }
        field(51; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(52; Time; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(53; "Repositioning Date"; date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(54; "Repositioning Time"; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(55; "Certificate No"; code[50])
        {

        }
        field(56; "Kephis Posted"; boolean)
        {

        }
        field(57; From; code[50])
        {

        }
        field(58; "TO"; code[50])
        {

        }
        field(59; "Repositioning Posted"; boolean)
        {

        }
        field(60; "Repair Posted"; boolean)
        {

        }
        field(61; Rescan; boolean)
        {

        }
        field(98; "Process Type Code"; Code[20])
        {
            Caption = 'Process Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PROCESS TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(99; "Client Type Code"; Code[20])
        {
            Caption = 'Client Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CLIENT TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(100; "Container Size"; Code[20])
        {
            Caption = 'Container Size';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CONTAINER SIZE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }


    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Rec."User ID" := UserId;
    end;
}

