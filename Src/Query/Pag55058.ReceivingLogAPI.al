page 55058 ReceivingLogAPI
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'receivingLogAPI';
    DelayedInsert = true;
    EntityName = 'ReceivingAPI';
    EntitySetName = 'ReceivingAPI';
    PageType = API;
    InsertAllowed = True;
    ModifyAllowed = True;
    SourceTable = ReceivingLog;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(blNo; Rec."BL No.")
                {
                    Caption = 'BL No.';
                }
                field(containerNoChassisNo; Rec."Container No./Chassis No.")
                {
                    Caption = 'Container No./Chassis No.';
                }
                field(containerType; Rec."Container Type")
                {
                    Caption = 'Container Type';
                }
                field(doNo; Rec."DO No.")
                {
                    Caption = 'DO No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(driverID; Rec."Driver ID")
                {
                    Caption = 'Driver ID';
                }
                field(driverName; Rec."Driver Name")
                {
                    Caption = 'Driver Name';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(jobFileNo; Rec."Job File No.")
                {
                    Caption = 'Job File No.';
                }
                field(manifestLineNo; Rec."Manifest Line No.")
                {
                    Caption = 'Manifest Line No.';
                }
                field(modified; Rec.Modified)
                {
                    Caption = 'Modified';
                }
                field(position; Rec.Position)
                {
                    Caption = 'Position';
                }
                field(receivedDate; Rec."Received Date")
                {
                    Caption = 'Received Date';
                }
                field(receivedQuantity; Rec."Received Quantity")
                {
                    Caption = 'Received Quantity';
                }
                field(recieived; Rec.Recieived)
                {
                    Caption = 'Recieived';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(timeIn; Rec."Time In")
                {
                    Caption = 'Time In';
                }
                field(trailerNo; Rec."Trailer No.")
                {
                    Caption = 'Trailer No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(transporter; Rec.Transporter)
                {
                    Caption = 'Transporter';
                }
                field(transporterName; Rec."Transporter Name")
                {
                    Caption = 'Transporter Name';
                }
                field(truckWagonNo; Rec."Truck /Wagon No.")
                {
                    Caption = 'Truck /Wagon No.';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(vehicle; Rec.Vehicle)
                {
                    Caption = 'Vehicle';
                }
                field(vehicleType; Rec."Vehicle Type")
                {
                    Caption = 'Vehicle Type';
                }
            }
        }
    }
}
