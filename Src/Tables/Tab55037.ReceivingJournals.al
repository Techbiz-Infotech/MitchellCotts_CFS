table 55037 "Receiving Journal"
{
    Caption = 'Receiving Journal';
    DataClassification = ToBeClassified;
    fields
    {
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(3; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
        }
        field(4; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Container No./Chassis No."; code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;

        }
        field(6; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        // field(7; "Container Size"; Enum ContainerSizeEnum)
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        // }
        field(7; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; Vehicle; Code[20])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
            //TableRelation = Vehicle;

            trigger OnValidate()
            var
                VehicleRec: Record "Fixed Asset";
            begin
                // IF VehicleRec.get(Vehicle) then begin
                //     "Trailer No." := VehicleRec.Trailer;
                //     "Driver Name" := VehicleRec."Driver Name";
                //     "Driver ID" := VehicleRec."ID No."
                // end else begin
                //     "Trailer No." := '';
                //     "Driver Name" := '';
                //     "Driver ID" := '';
                // end;
            end;
        }
        field(10; "Driver Name"; Text[30])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(11; "Driver ID"; Text[20])
        {
            Caption = 'Driver ID';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(12; "DO No."; Text[20])
        {
            Caption = 'DO No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Time In"; Time)
        {
            Caption = 'Time In';
            DataClassification = ToBeClassified;
        }
        field(14; Recieived; Boolean)
        {
            Caption = 'Recieived';
            DataClassification = ToBeClassified;
        }
        field(15; "Received Date"; Date)
        {
            Caption = 'Received Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin
                if "Received Date" > Today then
                    Error('You can not enter greater than %1', Today);
            end;
        }
        field(16; Transporter; Text[50])
        {
            Caption = 'Transporter';
            DataClassification = ToBeClassified;
            TableRelation = Transporter;
            trigger OnValidate()
            var
                TransporterRec: Record Transporter;
            begin
                if TransporterRec.get(Transporter) then
                    "Transporter Name" := TransporterRec."Transporter Name"
                else
                    "Transporter Name" := '';
            end;
        }
        field(17; "Vehicle Type"; Enum VehicleTypeEnum)
        {
            Caption = 'Vehicle Type';
            DataClassification = ToBeClassified;
        }
        field(18; "Truck /Wagon No."; Code[10])
        {
            Caption = 'Truck /Wagon No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Trailer No."; Code[10])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Shipper Seal No."; Code[20])
        {
            Caption = 'Shipper Seal No.';
            DataClassification = ToBeClassified;
        }
        field(21; "Container Structural Status"; Enum ContainerStructuralStatusEnum)
        {
            Caption = 'Container Structural Status';
            DataClassification = ToBeClassified;
        }
        field(22; "Releasing Clerk Details"; Text[50])
        {
            Caption = 'Receiving Clerk Details';
            DataClassification = ToBeClassified;
        }
        field(23; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(24; "No.Series"; code[20])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(25; "Manifest Line No."; Integer)
        {
            Caption = 'Manifest Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Received By"; Enum ReceivedByEnum)
        {
            Caption = 'Received By';
            DataClassification = ToBeClassified;
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }

        field(29; Image; MediaSet)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
            DataClassification = ToBeClassified;

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
        field(43; "Seal No. 1"; Text[100])
        {
            Caption = 'Seal No. 1';
            DataClassification = ToBeClassified;
        }
        field(44; "Seal No. 2"; Text[100])
        {
            Caption = 'Seal No. 2';
            DataClassification = ToBeClassified;
        }
        field(45; "Transporter Name"; Text[100])
        {
            Caption = 'Transporter Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; Position; code[50])
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Open));
        }
        field(47; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(48; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));

            trigger OnValidate()
            begin

                UpdateJournalBatchID();
            end;
        }
        field(49; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(8006; "Journal Batch Id"; Guid)
        {
            Caption = 'Journal Batch Id';
            TableRelation = "Gen. Journal Batch".SystemId;

            trigger OnValidate()
            begin
                UpdateJournalBatchName();
            end;
        }
        field(50; "Received Quantity"; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(51; "Remaining Quantity"; decimal)
        {
            DataClassification = ToBeClassified;
            Editable = False;

        }
        field(52; "Process Type Code"; Code[20])
        {
            Caption = 'Process Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PROCESS TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(53; "Client Type Code"; Code[20])
        {
            Caption = 'Client Type';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CLIENT TYPE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }
        field(54; "Container Size"; Code[20])
        {
            Caption = 'Container Size';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CONTAINER SIZE'),
                                                 "Dimension Value Type" = CONST(Standard),
                                                 Blocked = CONST(false));
        }

    }
    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Imssetup: record "IMS Setup";
    begin
        Imssetup.get;
        "Journal Template Name" := Imssetup."Journal Template Name";
        "User ID" := USERID;

    end;

    procedure UpdateJournalBatchID()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            exit;
        "Journal Batch Id" := GenJournalBatch.SystemId;

    end;

    local procedure UpdateJournalBatchName()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.GetBySystemId("Journal Batch Id") then
            exit;

        "Journal Batch Name" := GenJournalBatch.Name;
    end;

}
