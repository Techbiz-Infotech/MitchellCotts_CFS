tableextension 55001 "Purchase Cr Memo Line Ext" extends "Purch. Cr. Memo Line"
{
    fields
    {
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
            ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
    }

}
