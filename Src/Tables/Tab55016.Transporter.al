table 55016 Transporter
{
    Caption = 'Transporter';
    DataClassification = ToBeClassified;
    LookupPageId = Transporters;
    DrillDownPageId = Transporters;

    fields
    {
        field(1; "Transporter Code"; Code[50])
        {
            Caption = 'Transporter Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Transporter Name"; Text[100])
        {
            Caption = 'Transporter Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.get("Vendor No.") then begin
                    "Vendor Name" := Vend.Name;
                    Email := Vend."E-Mail"
                end
                else begin
                    "Vendor Name" := '';
                    Email := '';
                end;
            end;
        }
        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(5; Email; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Vehicle No"; code[70])
        {

        }
        field(7; "Trailer No"; code[10])
        {

        }
    }
    keys
    {
        key(PK; "Transporter Code")
        {
            Clustered = true;
        }
    }
}
