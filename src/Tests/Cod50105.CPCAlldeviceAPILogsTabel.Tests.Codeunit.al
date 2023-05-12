codeunit 50105 CPCAlldeviceApiLogsTabelTests
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestCreateAPILogSpares()
    var
        NumberBeforeSync: Integer;
        NumberAfterSync: Integer;
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        NumberBeforeSync := ApiLogs.Count;
        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        NumberAfterSync := ApiLogs.Count;

        Assert.IsTrue(NumberAfterSync > NumberBeforeSync, 'No rows inserted');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestCreateAPILogManufacturers()
    var
        NumberBeforeSync: Integer;
        NumberAfterSync: Integer;
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        NumberBeforeSync := ApiLogs.Count;
        ApiSetup.OpenEdit();
        ApiSetup.GetManufacturers.Invoke();
        NumberAfterSync := ApiLogs.Count;

        Assert.IsTrue(NumberAfterSync > NumberBeforeSync, 'No rows inserted');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestCreateAPILogCategories()
    var
        NumberBeforeSync: Integer;
        NumberAfterSync: Integer;
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        NumberBeforeSync := ApiLogs.Count;
        ApiSetup.OpenEdit();
        ApiSetup.GetCategories.Invoke();
        NumberAfterSync := ApiLogs.Count;

        Assert.IsTrue(NumberAfterSync > NumberBeforeSync, 'No rows inserted');
    end;

    [Test]
    procedure TestDontCreateAPILog()
    var
        NumberBeforeSync: Integer;
        NumberAfterSync: Integer;
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        NumberBeforeSync := ApiLogs.Count;
        ApiSetup.OpenEdit();
        ApiSetup."CPC Alldevice API Username".SetValue(Random.AlphabeticText(100));
        asserterror ApiSetup.GetSpares.Invoke();
        NumberAfterSync := ApiLogs.Count;

        Assert.IsTrue(NumberAfterSync = NumberBeforeSync, 'Rows inserted');
    end;

    [ModalPageHandler]
    procedure ErrorMessagesHandler(var ErrorMessages: TestPage "Error Messages")
    begin
        ErrorMessages.OK().Invoke();
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonSpares()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        if ApiLogs."CPC Response JSON Data".HasValue then begin
            ApiLogs.OpenResponseJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open response json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonSparesNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        ApiLogs."CPC Response JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Response json text is empty');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonCategories()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetCategories.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        if ApiLogs."CPC Response JSON Data".HasValue then begin
            ApiLogs.OpenResponseJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open response json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonCategoriesNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        ApiLogs."CPC Response JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Response json text is empty');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonManufacturers()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetManufacturers.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        if ApiLogs."CPC Response JSON Data".HasValue then begin
            ApiLogs.OpenResponseJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open response json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenResponseJsonManufacturersNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetManufacturers.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Response JSON Data");
        ApiLogs."CPC Response JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Response json text is empty');
    end;

    [Test]
    procedure TestDontOpenResponseJson()
    var
        ApiLogsPage: TestPage "CPC Alldevice API Logs";
        ApiLogsRec: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        ApiLogsRec.DeleteAll();
        ApiLogsPage.OpenEdit();
        ApiLogsPage.GoToRecord(ApiLogsRec);
        asserterror ApiLogsPage.ViewResponseJson.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Response json exsists');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonSpares()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        if ApiLogs."CPC Sent JSON Data".HasValue then begin
            ApiLogs.OpenSentJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open sent json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonSparesNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetSpares.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        ApiLogs."CPC Sent JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Sent json text is empty');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonCategories()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetCategories.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        if ApiLogs."CPC Sent JSON Data".HasValue then begin
            ApiLogs.OpenSentJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open sent json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonCategoriesNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetCategories.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        ApiLogs."CPC Sent JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Sent json text is empty');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonManufacturers()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        IsRun: Boolean;
    begin
        IsRun := false;

        ApiSetup.OpenEdit();
        ApiSetup.GetManufacturers.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        if ApiLogs."CPC Sent JSON Data".HasValue then begin
            ApiLogs.OpenSentJson();
            IsRun := true;
        end;

        Assert.IsTrue(IsRun, 'Open sent json doesn''t run');
    end;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestOpenSentJsonManufacturersNotBlank()
    var
        ApiLogs: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
        InStream: InStream;
        TextToTest: Text;
    begin
        ApiSetup.OpenEdit();
        ApiSetup.GetManufacturers.Invoke();
        ApiSetup.Close();

        ApiLogs.FindLast();
        ApiLogs.CalcFields("CPC Sent JSON Data");
        ApiLogs."CPC Sent JSON Data".CreateInStream(InStream);
        InStream.ReadText(TextToTest);

        Assert.IsTrue(StrLen(TextToTest) > 2, 'Sent json text is empty');
    end;

    [Test]
    procedure TestDontOpenSentJson()
    var
        ApiLogsPage: TestPage "CPC Alldevice API Logs";
        ApiLogsRec: Record "CPC Alldevice API Logs";
        ApiSetup: TestPage "CPC Alldevice API Setup";
    begin
        ApiLogsRec.DeleteAll();
        ApiLogsPage.OpenEdit();
        ApiLogsPage.GoToRecord(ApiLogsRec);
        asserterror ApiLogsPage.ViewSentJson.Invoke();

        Assert.IsTrue(GetLastErrorText() <> '', 'Response json exsists');
    end;

    var
        Assert: Codeunit "Library Assert";
        Random: Codeunit Any;
}