codeunit 50103 CPCAlldevicemanufacturerTests
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestAddManufacturersFromAlldevice()
    var
        SyncManufacturer: Codeunit "CPC Alldevice Manufacturer";
        Manufacturer: Record Manufacturer;
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := Manufacturer.Count;
        SyncManufacturer.Run();
        NumberAfterFunc := Manufacturer.Count;

        Assert.IsTrue(NumberAfterFunc > NumberBeforeFunc, 'Manufacturers not inserted');
    end;

    [Test]
    procedure TestDontAddManufacturersFromAlldevice()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        Manufacturer: Record Manufacturer;
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := Manufacturer.Count;
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Manuf. List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetManufacturers.Invoke();
        NumberAfterFunc := Manufacturer.Count;

        Assert.IsTrue(NumberAfterFunc = NumberBeforeFunc, 'Manufacturers inserted');
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