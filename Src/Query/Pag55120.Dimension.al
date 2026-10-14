page 55120 Dimension
{
    APIGroup = 'apiGroup';
    APIPublisher = 'TechbizInfoTech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'dimension';
    DelayedInsert = true;
    EntityName = 'DimensionAPI';
    EntitySetName = 'DimensionAPI';
    PageType = API;
    SourceTable = "Dimension Value";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(dimensionId; Rec."Dimension Id")
                {
                    Caption = 'Dimension Id';
                }
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field(dimensionValueID; Rec."Dimension Value ID")
                {
                    Caption = 'Dimension Value ID';
                }
                field(dimensionValueType; Rec."Dimension Value Type")
                {
                    Caption = 'Dimension Value Type';
                }
                field(globalDimensionNo; Rec."Global Dimension No.")
                {
                    Caption = 'Global Dimension No.';
                }
                field(jobFileNo; Rec."Job File No.")
                {
                    Caption = 'Job File No.';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Shortcut Dimension 6 Code';
                }
                field(skipKPACharges; Rec."Skip KPA Charges")
                {
                    Caption = 'Skip KPA Charges';
                }
            }
        }
    }
}
