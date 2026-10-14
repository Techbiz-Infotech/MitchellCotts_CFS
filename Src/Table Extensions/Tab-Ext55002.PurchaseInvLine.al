tableextension 55002 PurchaseInvLine extends "Purch. Inv. Line"
{
    fields
    {
        field(50100; "Description of goods"; Text[250])
        {
            Caption = 'Description of goods';
            DataClassification = ToBeClassified;
        }
        field(50101; "IMS Item Category Code"; Code[20])
        {
            Caption = 'IMS Item Category Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("No.")));
        }
        field(50102; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            ToolTip = 'Specifies the code for Shortcut Dimension 4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

        }
        field(50103; "BL No"; code[30])
        {
            DataClassification = ToBeClassified;

        }


    }
}
