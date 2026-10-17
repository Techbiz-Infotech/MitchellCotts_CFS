page 55126 ChargeAssignmentAPI
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'chargeAssignmentAPI';
    DelayedInsert = true;
    EntityName = 'ChargeAssignmentAPI';
    EntitySetName = 'ChargeAssignmentAPI';
    PageType = API;
    SourceTable = "Charge ID Assignment";
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(destinationLocalOrTransit; Rec."Destination Local or Transit")
                {
                    Caption = 'Destination Local or Transit';
                }
                field(containerSize; Rec."Container Size")
                {
                    Caption = 'Container Size';
                }
                field(SystemId; Rec.SystemId)
                { }
                field(chargeIdGroupCode; Rec."Charge Id Group Code")
                {
                    Caption = 'Charge Id Group Code';
                }
                field(chargeType; Rec."Charge Type")
                {
                    Caption = 'Charge Type';
                }
                field(clearingAgentCode; Rec."Clearing Agent Code")
                {
                    Caption = 'Clearing Agent Code';
                }
                field(clientTypeCode; Rec."Client Type Code")
                {
                    Caption = 'Client Type Code';
                }
                field(assignmentStatus; Rec."Assignment Status")
                {
                    Caption = 'Assignment Approval Status';
                }
                field(effectiveFromDate; Rec."Effective From Date")
                {
                    Caption = 'Effective From Date';
                }
                field(effectiveToDate; Rec."Effective To Date")
                {
                    Caption = 'Effective To Date';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(processTypeCode; Rec."Process Type Code")
                {
                    Caption = 'Process Type';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(unitTypeContainerTypeVehic; Rec."Unit Type Container type/Vehic")
                {
                    Caption = 'Unit Type Container type or Vehicle';
                }
            }
        }
    }
}
