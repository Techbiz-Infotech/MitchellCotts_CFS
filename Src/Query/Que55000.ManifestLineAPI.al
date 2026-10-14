page 55213 "Manifest Line Update API"
{
    PageType = API;
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    EntityName = 'ManifestLineAPI';
    EntitySetName = 'ManifestLineAPI';
    SourceTable = "Manifest Line";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                // Keys / system - read only
                field(systemId; Rec.SystemId) { Editable = false; }
                field(jobFileNo; Rec."Job File No.") { Editable = false; }
                field(lineNo; Rec."Line No.") { Editable = false; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { Editable = false; }

                // FlowFields - read only
                field(invoices; Rec.Invoices) { Editable = false; }
                field(creditMemos; Rec."Credit Memos") { Editable = false; }

                // Updatable fields
                field(allocatedPosition; Rec."Allocated Position") { }
                field(expectedArrivalDate; Rec."Expected Arrival Date") { }
                field(vesselArrivalDate; Rec."Vessel Arrival Date") { }
                field(vesselArrivalTime; Rec."Vessel Arrival Time") { }
                field(blNo; Rec."BL No.") { }
                field(cbmTonage; Rec."CBM Tonage") { }
                field(cbmWtDifference; Rec."CBM-Wt Difference") { }
                field(chargeID; Rec."Charge ID") { }
                field(clearingAgent; Rec."Clearing Agent") { }
                field(clientReferenceNo; Rec."Client Reference No.") { }
                field(consigneeName; Rec."Consignee Name") { }
                field(consigneeNo; Rec."Consignee No.") { }
                field(containerType; Rec."Container Type") { }
                field(containerLock; Rec."Container lock") { }
                field(containerChassisNo; Rec."Container/Chassis No.") { }
                field(customEntryNo; Rec."Custom Entry No.") { }
                field(customsSealNo; Rec."Customs Seal No.") { }
                field(dateReceived; Rec."Date Received") { }
                field(dateReleased; Rec."Date Released") { }
                field(deliveryOrderNo; Rec."Delivery Order No.") { }
                field(description; Rec.Description) { }
                field(destinationType; Rec."Destination Type") { }
                field(dischargeDate; Rec."Discharge Date") { }
                field(docsReceivedDate; Rec."Docs Received Date") { }
                field(driverID; Rec."Driver ID") { }
                field(driverName; Rec."Driver Name") { }
                field(emptyContainer; Rec."Empty Container") { }
                field(containerStatus; Rec."Container Status") { }
                field(finalDestination; Rec."Final Destination") { }
                field(gpDeliveryOrderNo; Rec."GP Delivery Order No.") { }
                field(globalDimension1Code; Rec."Global Dimension 1 Code") { }
                field(globalDimension2Code; Rec."Global Dimension 2 Code") { }
                field(icdnInDate; Rec."ICDN In-Date") { }
                field(invoicingPartyNo; Rec."Invoicing Party No.") { }
                field(jobFileDate; Rec."Job File Date") { }
                field(landingDate; Rec."Landing Date") { }
                field(landingTime; Rec."Landing Time") { }
                field(lockNo; Rec."Lock No.") { }
                field(manifested; Rec.Manifested) { }
                field(marks; Rec.Marks) { }
                field(noOfBags; Rec."No. of Bags") { }
                field(noOfBagsReleased; Rec."No. of Bags Released") { }
                field(oppertunityNo; Rec."Oppertunity No.") { }
                field(otherRemarks; Rec."Other remarks") { }
                field(parentContainerID; Rec."Parent Container ID") { }
                field(portOfDischarge; Rec."Port of Discharge") { }
                field(portOfShipment; Rec."Port of Shipment") { }
                field(railedDate; Rec."Railed Date") { }
                field(received; Rec.Received) { }
                field(receivedBy; Rec."Received By") { }
                field(receivedTime; Rec."Received Time") { }
                field(released; Rec.Released) { }
                field(remainingBags; Rec."Remaining Bags") { }
                field(sicdInDate; Rec."SICD In-Date") { }
                field(salesQuoteNo; Rec."Sales Quote No.") { }
                field(sealLocked; Rec."Seal Locked?") { }
                field(sealTagged; Rec."Seal Tagged?") { }
                field(sealEngineNo; Rec."Seal/Engine No.") { }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code") { }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code") { }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code") { }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code") { }
                field(stripped; Rec.Stripped) { }
                field(strippingDate; Rec."Stripping Date") { }
                field(strippingNotes; Rec."Stripping Notes") { }
                field(strippingTime; Rec."Stripping Time") { }
                field(tblMH; Rec."TBL/MH") { }
                field(transporter; Rec.Transporter) { }
                field(transporterName; Rec."Transporter Name") { }
                field(userID; Rec."User ID") { }
                field(vehicle; Rec.Vehicle) { }
                field(verificationNotes; Rec."Verification Notes") { }
                field(verificationPrintDate; Rec."Verification Print Date") { }
                field(verificationTime; Rec."Verification Time") { }
                field(verificationType; Rec."Verification Type") { }
                field(verified; Rec.Verified) { }
                field(weight; Rec.Weight) { }
                field(manifestNo; Rec."Manifest No") { }
                field(rescan; Rec.Rescan) { }
                field(vesselName; Rec."Vessel Name") { }
                field(voyageNo; Rec."Voyage No.") { }
                field(processTypeCode; Rec."Process Type Code") { }
                field(containerSize; Rec."Container Size") { }
                field(clientTypeCode; Rec."Client Type Code") { }
            }
        }
    }
}