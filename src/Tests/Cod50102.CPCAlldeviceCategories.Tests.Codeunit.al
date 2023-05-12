codeunit 50102 CPCAlldeviceCategoriesTests
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    [HandlerFunctions('ErrorMessagesHandler')]
    procedure TestAddCategoriesFromAlldevice()
    var
        SyncCategories: Codeunit "CPC Alldevice Categories";
        ItemCategory: Record "Item Category";
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := ItemCategory.Count;
        SyncCategories.Run();
        NumberAfterFunc := ItemCategory.Count;

        Assert.IsTrue(NumberAfterFunc > NumberBeforeFunc, 'Categories not inserted');
    end;

    [Test]
    procedure TestDontAddCategoriesFromAlldevice()
    var
        AlldeviceAPISetup: TestPage "CPC Alldevice API Setup";
        ItemCategory: Record "Item Category";
        NumberBeforeFunc: Integer;
        NumberAfterFunc: Integer;
    begin
        NumberBeforeFunc := ItemCategory.Count;
        AlldeviceAPISetup.OpenEdit();
        AlldeviceAPISetup."CPC Get Categories List Prefix".SetValue(Random.AlphabeticText(15));
        asserterror AlldeviceAPISetup.GetCategories.Invoke();
        NumberAfterFunc := ItemCategory.Count;

        Assert.IsTrue(NumberAfterFunc = NumberBeforeFunc, 'Categories inserted');
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