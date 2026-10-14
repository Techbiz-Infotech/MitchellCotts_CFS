table 55028 Stripping
{
    Caption = 'Stripping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Stripping No."; Code[10])
        {
            Caption = 'Stripping No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Stripping Date"; Date)
        {
            Caption = 'Stripping Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Stripping Time"; Time)
        {
            Caption = 'Stripping Time';
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
        field(9; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Stripping Type"; enum "Stripping TypeEnum")
        {
            Caption = 'Stripping Type';
            DataClassification = ToBeClassified;

        }
        field(11; "Stripping Notes"; Text[30])
        {
            Caption = 'Stripping Notes';
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
        field(14; Stripped; Boolean)
        {
            Caption = 'Stripped';
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
        field(44; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(45; "Storage Location"; enum "Stripping Location")
        {
            DataClassification = ToBeClassified;

        }
        field(46; Location; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Storage Location" = const(Yard)) Position
            else
            if ("Storage Location" = const(Warehouse)) Location;



        }
        field(47; Bins; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code where("Location Code" = field(Location));

        }
        field(48; "Process Type Code"; Code[20])
        {
            Caption = 'Process Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PROCESS TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(49; "Client Type Code"; Code[20])
        {
            Caption = 'Client Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CLIENT TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(50; "Container Size"; Code[20])
        {
            Caption = 'Container Size';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CONTAINER SIZE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(51; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
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

