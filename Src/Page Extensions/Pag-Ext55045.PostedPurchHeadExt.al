pageextension 55045 PostedPurchHeadExt extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("CU Number"; Rec."CU Number")
            {
                caption = 'CU Number';
                ApplicationArea = All;
            }
        }
    }
}
