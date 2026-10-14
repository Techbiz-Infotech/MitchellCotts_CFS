table 55040 "Credit Gross Margin"
{
    Caption = 'Credit Gross Margin';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = True;
        }
        field(2; "G/L Account"; Code[50])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GL: record "G/L Account";
            begin
                GL.reset;
                GL.SetRange("No.", Rec."G/L Account");
                if GL.FindFirst() then
                    "G/L Description" := GL.Name;

            end;
        }
        field(3; "G/L Description"; Code[100])
        {
            Editable = False;
        }
        field(4; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Storage Account","Var Cost Account";
        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
