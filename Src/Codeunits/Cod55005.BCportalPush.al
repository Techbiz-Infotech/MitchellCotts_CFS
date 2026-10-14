codeunit 55005 "BC  portal Push"
{

    procedure PushChange(Action: Text; Payload: JsonObject): Boolean
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        Response: HttpResponseMessage;
        Envelope: JsonObject;
        Body: Text;
        ResponseText: Text;
    begin
        Envelope.Add('action', Action);
        Envelope.Add('api_request_id', Format(CreateGuid()));
        Envelope.Add('payload', Payload);
        Envelope.Add('date_time', Format(CurrentDateTime, 0, 9));
        Envelope.WriteTo(Body);

        Content.WriteFrom(Body);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        Client.DefaultRequestHeaders().Add('ngrok-skip-browser-warning', 'true');
        Client.Timeout(10000);

        if not Client.Post(GetEndpoint(), Content, Response) then begin
            Message('FAILED to reach endpoint.\Sent: %1', Body);
            exit(false);
        end;

        Response.Content.ReadAs(ResponseText);
        Message('Status: %1\Sent: %2\Reply: %3', Response.HttpStatusCode(), Body, ResponseText);
        exit(Response.IsSuccessStatusCode());
    end;

    local procedure GetEndpoint(): Text
    begin
        exit('https://678c-2605-59c1-44fd-f14-6918-49c-4d95-8f73.ngrok-free.app/api/v1/webhooks/erp-probe');
    end;

    // --- Manifest Line: Rescan flipped to true ---

    [EventSubscriber(ObjectType::Table, Database::"Manifest Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure ManifestLine_OnAfterModify(var Rec: Record "Manifest Line"; var xRec: Record "Manifest Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;

        if Rec.Manifested and not xRec.Manifested then
            PushChange('MANIFEST_LINE_RESCAN', BuildManifestLine(Rec));
    end;

    local procedure BuildManifestLine(Rec: Record "Manifest Line") Datum: JsonObject
    begin
        Datum.Add('jobfile_No', Rec."Job File No.");
        Datum.Add('Container_ID', Rec."Container/Chassis No.");
        Datum.Add('rescan', Rec.Manifested);
    end;
}


