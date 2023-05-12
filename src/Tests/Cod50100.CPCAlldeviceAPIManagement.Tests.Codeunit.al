codeunit 50100 CPCAlldeviceAPIManagementTests
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestGetRequestJsonWithAuthentication()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        JsonObjectText: Text;
    begin
        APIManagement.GetRequestJsonWithAuth().WriteTo(JsonObjectText);

        Assert.IsTrue(JsonObjectText <> '', 'Is empty');
    end;

    [Test]
    procedure TestDontGetRequestJsonWithAuthenticationSpares()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        APIManagement: Codeunit "CPC Alldevice API Management";
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Alldevice API Username".SetValue(Random(100));
        asserterror AlldeviceAPISetup.GetSpares.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Error is raised');
    end;

    [Test]
    procedure TestDontGetRequestJsonWithAuthenticationCategories()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        APIManagement: Codeunit "CPC Alldevice API Management";
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Alldevice API Username".SetValue(Random(100));
        asserterror AlldeviceAPISetup.GetCategories.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Error is raised');
    end;

    [Test]
    procedure TestDontGetRequestJsonWithAuthenticationManufacturers()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        APIManagement: Codeunit "CPC Alldevice API Management";
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Alldevice API Username".SetValue(Random(100));
        asserterror AlldeviceAPISetup.GetManufacturers.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Error is raised');
    end;

    [Test]
    procedure TestGetJsonToken()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        JsonTokenText: Text;
    begin
        APIManagement.GetJsonToken(APIManagement.GetRequestJsonWithAuth(), 'auth').WriteTo(JsonTokenText);

        Assert.IsTrue(JsonTokenText <> '', 'Is empty');
    end;

    [Test]
    procedure TestDontGetJsonToken()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        Error001: Label 'Could not find a token with key %1', Locked = true;
        JsonTokenText: Text;
    begin
        JsonTokenText := Random.AlphabeticText(4);
        asserterror APIManagement.GetJsonToken(APIManagement.GetRequestJsonWithAuth(), JsonTokenText);

        Assert.IsTrue(GetLastErrorText() = StrSubstNo(Error001, JsonTokenText), 'Errors are not equal');
    end;

    [Test]
    procedure TestSelectJsonToken()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        JsonPathText: Text;
    begin
        APIManagement.SelectJsonToken(APIManagement.GetRequestJsonWithAuth(), '$.auth').WriteTo(JsonPathText);

        Assert.IsTrue(JsonPathText <> '', 'Is empty');
    end;

    [Test]
    procedure TestDontSelectJsonToken()
    var
        Path: Text;
        Error002: Label 'Could not find a token with path %1', Locked = true;
        APIManagement: Codeunit "CPC Alldevice API Management";
    begin
        Path := Random.AlphabeticText(10);
        asserterror APIManagement.SelectJsonToken(APIManagement.GetRequestJsonWithAuth(), Path);

        Assert.IsTrue(GetLastErrorText = StrSubstNo(Error002, Path), 'Errors are equal');
    end;

    [Test]
    procedure TestGetListSpares()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();
        ResponseText := APIManagement.GetList(AlldeviceAPISetup."CPC Get Spares List Prefix");
        Response.Content.ReadAs(ResponseText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    [Test]
    procedure TestGetListCategories()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();
        ResponseText := APIManagement.GetList(AlldeviceAPISetup."CPC Get Categories List Prefix");
        Response.Content.ReadAs(ResponseText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    [Test]
    procedure TestGetListManufacturers()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();
        ResponseText := APIManagement.GetList(AlldeviceAPISetup."CPC Get Manuf. List Prefix");
        Response.Content.ReadAs(ResponseText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    [Test]
    procedure TestGetListTasks()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();
        ResponseText := APIManagement.GetList(AlldeviceAPISetup."CPC Get Service Task List");
        Response.Content.ReadAs(ResponseText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    [Test]
    procedure TestDontGetListSpares()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        Prefix: Text;
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Spares List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetSpares.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Error raised');
    end;

    [Test]
    procedure TestDontGetListCategories()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        Prefix: Text;
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Categories List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetSpares.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'No error raised');
    end;

    [Test]
    procedure TestDontGetListManufacturers()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        Prefix: Text;
        ResponseText: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Manuf. List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetSpares.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'No error raised');
    end;

    [Test]
    procedure TestDontGetListTasks()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        AlldeviceTasksPage: TestPage "CPC Alldevice Tasks List";
    begin
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Service Task List".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceTasksPage.OpenEdit();

        Assert.IsTrue(GetLastErrorText() <> '', 'No error raised');
    end;

    [Test]
    procedure TestPostRequestSpares()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        JsonObject: JsonObject;
        JsonObjectText: Text;
        Item: Record Item;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();

        Item := CreateItemSpare();

        JsonObject := APIManagement.GetRequestJsonWithAuth();
        JsonObject.Add('name', Item.Description);
        JsonObject.Add('code', Item."No.");
        JsonObject.Add('product_id', Item."CPC Alldevice Product Id");

        APIManagement.PostRequest(AlldeviceAPISetup."CPC Update or Add Spare Prefix", JsonObject).WriteTo(JsonObjectText);
        Response.Content.ReadAs(JsonObjectText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    local procedure CreateItemSpare(): Record Item
    var
        Item: Record Item;
    begin
        Item.Init();
        Item."No." := Random.AlphanumericText(5);
        Item.Description := Random.AlphabeticText(10);
        Item."CPC Alldevice Spare" := true;
        Item."CPC Alldevice Product Id" := Random.DecimalInRange(15, 0);
        Item.Insert();
        exit(Item);
    end;

    [Test]
    procedure TestPostRequestCategories()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        JsonObject: JsonObject;
        JsonObjectText: Text;
        ItemCategory: Record "Item Category";
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();

        ItemCategory := CreateItemCategory();

        JsonObject := APIManagement.GetRequestJsonWithAuth();
        JsonObject.Add('name', ItemCategory.Code);
        JsonObject.Add('cat_id', ItemCategory."CPC Alldevice Category Id");

        APIManagement.PostRequest(AlldeviceAPISetup."CPC Update or add Cat. Prefix", JsonObject).WriteTo(JsonObjectText);
        Response.Content.ReadAs(JsonObjectText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    local procedure CreateItemCategory(): Record "Item Category";
    var
        ItemCategory: Record "Item Category";
    begin
        ItemCategory.Init();
        ItemCategory.Code := Random.AlphanumericText(5);
        ItemCategory."CPC Alldevice Category Id" := Random.DecimalInRange(15, 0);
        ItemCategory.Insert();
        exit(ItemCategory);
    end;

    [Test]
    procedure TestPostRequestManufacturers()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        JsonObject: JsonObject;
        JsonObjectText: Text;
        Manufacturer: Record Manufacturer;
        Response: HttpResponseMessage;
        Content: HttpContent;
    begin
        AlldeviceAPISetup.Get();

        Manufacturer := CreateManufacturer();

        JsonObject := APIManagement.GetRequestJsonWithAuth();
        JsonObject.Add('name', Manufacturer.Code);
        JsonObject.Add('id', Manufacturer."CPC Alldevice Manufacturer Id");

        APIManagement.PostRequest(AlldeviceAPISetup."CPC Update or add manuf. Pref.", JsonObject).WriteTo(JsonObjectText);
        Response.Content.ReadAs(JsonObjectText);

        Assert.IsTrue(Response.IsSuccessStatusCode, 'Status code is failure');
    end;

    local procedure CreateManufacturer(): Record Manufacturer;
    var
        Manufacturer: Record Manufacturer;
    begin
        Manufacturer.Init();
        Manufacturer.Code := Random.AlphanumericText(5);
        Manufacturer."CPC Alldevice Manufacturer Id" := Random.DecimalInRange(15, 0);
        Manufacturer.Insert();
        exit(Manufacturer);
    end;

    [Test]
    procedure TestDontPostRequest()
    var
        APIManagement: Codeunit "CPC Alldevice API Management";
        AlldeviceAPISetup: Record "CPC Alldevice API Setup";
        JsonObject: JsonObject;
        JsonObjectText: Text;
        Prefix: Text;
    begin
        AlldeviceAPISetup.Get();
        Prefix := Random.AlphabeticText(15);
        asserterror APIManagement.PostRequest(Prefix, JsonObject).WriteTo(JsonObjectText);

        Assert.IsTrue(GetLastErrorText() <> '', 'Error doesn''t raise');
    end;

    [Test]
    procedure TestAlldeviceAPISetupOpenPage()
    var
        AlldeviceAPISetupPage: TestPage "CPC Alldevice API Setup";
        AlldeviceAPISetupTable: Record "CPC Alldevice API Setup";
        RowCountBeforOpenPage: Integer;
        RowCountAfterOpenPage: Integer;
    begin
        AlldeviceAPISetupTable.DeleteAll();
        RowCountBeforOpenPage := AlldeviceAPISetupTable.Count;
        AlldeviceAPISetupPage.OpenEdit();
        RowCountAfterOpenPage := AlldeviceAPISetupTable.Count;

        Assert.IsTrue(RowCountBeforOpenPage < RowCountAfterOpenPage, 'Row count doesn''t change');
    end;

    var
        Assert: Codeunit "Library Assert";
        Random: Codeunit Any;
}