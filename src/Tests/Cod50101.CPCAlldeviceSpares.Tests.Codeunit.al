codeunit 50101 CPCAlldeviceSparesTests
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestAddSparesFromAlldevice()
    var
        SyncSpares: Codeunit "CPC Alldevice Spares";
        Item: Record Item;
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := Item.Count;
        SyncSpares.Run();
        NumberAfterFunc := Item.Count;

        Assert.IsTrue(NumberAfterFunc > NumberBeforeFunc, 'Spares not inserted');
    end;

    [Test]
    procedure TestDontAddSparesFromAlldevice()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        Item: Record Item;
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := Item.Count;
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Spares List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetSpares.Invoke();
        NumberAfterFunc := Item.Count;

        Assert.IsTrue(NumberAfterFunc = NumberBeforeFunc, 'Spares inserted');
    end;

    [ModalPageHandler]
    procedure ErrorMessagesHandler(var ErrorMessages: TestPage "Error Messages")
    begin
        ErrorMessages.OK().Invoke();
    end;

    var
        Assert: Codeunit "Library Assert";
        Random: Codeunit Any;
}