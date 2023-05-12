codeunit 50104 CPCAlldeviceTasks
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestGetTasksRecord()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        NumberRowsBeforeOpenPage: Integer;
        NumberRowsAfterOpenPage: Integer;
    begin
        NumberRowsBeforeOpenPage := AlldeviceTasksTabel.Count;
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        NumberRowsAfterOpenPage := AlldeviceTasksTabel.Count;

        Assert.IsTrue(NumberRowsAfterOpenPage > NumberRowsBeforeOpenPage, 'Rows not inserted');
    end;

    [Test]
    procedure TestDontGetTasksRecord()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceAPISetupPage: TestPage "CPC Alldevice API Setup";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksPage: TestPage "CPC Alldevice Tasks List";
        NumberRowsBeforeOpenPage: Integer;
        NumberRowsAfterOpenPage: Integer;
    begin
        AlldeviceAPISetupPage.OpenEdit();
        AlldeviceAPISetupPage."CPC Get Service Task List".SetValue(Random.AlphabeticText(15));
        AlldeviceAPISetupPage.Close();
        
        NumberRowsBeforeOpenPage := AlldeviceTasksTabel.Count;
        asserterror AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        NumberRowsAfterOpenPage := AlldeviceTasksTabel.Count;

        Assert.IsTrue(NumberRowsBeforeOpenPage = NumberRowsAfterOpenPage, 'Rows inserted');
    end;

    [Test]
    procedure TestGetUsedSparesList()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksLineTabel: Record "CPC Alld. Service Task Lines" temporary;
        NumberRowsBeforeGetUsedSparesList: Integer;
        NumberRowsAfterGetUsedSparesList: Integer;
    begin
        NumberRowsBeforeGetUsedSparesList := AlldeviceTasksLineTabel.Count;
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        if AlldeviceTasksTabel.FindSet() then
            repeat
                AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLineTabel, AlldeviceTasksTabel."CPC Task Id");
                if AlldeviceTasksLineTabel.Count <> 0 then
                    NumberRowsAfterGetUsedSparesList := AlldeviceTasksLineTabel.Count;
            until (AlldeviceTasksTabel.Next(Random.DecimalInRange(10, 0)) = 0) or (AlldeviceTasksLineTabel.Count <> 0);

        Assert.IsTrue(NumberRowsAfterGetUsedSparesList > NumberRowsBeforeGetUsedSparesList, 'Rows not inserted');
    end;

    [Test]
    procedure TestGetUsedSparesListCheckFieldCPCId()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksLineTabel: Record "CPC Alld. Service Task Lines" temporary;
        NoEmpty: Boolean;
    begin
        AlldeviceTasksLineTabel.DeleteAll();
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        if AlldeviceTasksTabel.FindSet() then
            repeat
                AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLineTabel, AlldeviceTasksTabel."CPC Task Id");
                if AlldeviceTasksLineTabel.Count <> 0 then begin
                    AlldeviceTasksTabel.FindFirst();
                    NoEmpty := AlldeviceTasksLineTabel."CPC Id" <> 0;
                end;
            until (AlldeviceTasksTabel.Next(Random.DecimalInRange(10, 0)) = 0) or (AlldeviceTasksLineTabel.Count <> 0);

        Assert.IsTrue(NoEmpty, 'Field "CPC Id" Is Empty');
    end;

    [Test]
    procedure TestGetUsedSparesListCheckFieldCPCCode()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksLineTabel: Record "CPC Alld. Service Task Lines" temporary;
        NoEmpty: Boolean;
    begin
        AlldeviceTasksLineTabel.DeleteAll();
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        if AlldeviceTasksTabel.FindSet() then
            repeat
                AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLineTabel, AlldeviceTasksTabel."CPC Task Id");
                if AlldeviceTasksLineTabel.Count <> 0 then begin
                    AlldeviceTasksTabel.FindFirst();
                    NoEmpty := AlldeviceTasksLineTabel."CPC Code" <> '';
                end;
            until (AlldeviceTasksTabel.Next(Random.DecimalInRange(10, 0)) = 0) or (AlldeviceTasksLineTabel.Count <> 0);

        Assert.IsTrue(NoEmpty, 'Field "CPC Code" Is Empty');
    end;

    [Test]
    procedure TestGetUsedSparesListCheckFieldCPCAlldeviceTaskId()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksLineTabel: Record "CPC Alld. Service Task Lines" temporary;
        NoEmpty: Boolean;
    begin
        AlldeviceTasksLineTabel.DeleteAll();
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        if AlldeviceTasksTabel.FindSet() then
            repeat
                AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLineTabel, AlldeviceTasksTabel."CPC Task Id");
                if AlldeviceTasksLineTabel.Count <> 0 then begin
                    AlldeviceTasksTabel.FindFirst();
                    NoEmpty := AlldeviceTasksLineTabel."CPC Alldevice Task Id" <> 0;
                end;
            until (AlldeviceTasksTabel.Next(Random.DecimalInRange(10, 0)) = 0) or (AlldeviceTasksLineTabel.Count <> 0);

        Assert.IsTrue(NoEmpty, 'Field "CPC Alldevice Task Id" Is Empty');
    end;

    [Test]
    procedure TestGetUsedSparesListCheckFieldCPCQuantity()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceTasksTabel: Record "CPC Alldevice Service Tasks" temporary;
        AlldeviceTasksLineTabel: Record "CPC Alld. Service Task Lines" temporary;
        NoEmpty: Boolean;
    begin
        AlldeviceTasksLineTabel.DeleteAll();
        AlldeviceTasks.GetTasksRecord(AlldeviceTasksTabel);
        if AlldeviceTasksTabel.FindSet() then
            repeat
                AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLineTabel, AlldeviceTasksTabel."CPC Task Id");
                if AlldeviceTasksLineTabel.Count <> 0 then begin
                    AlldeviceTasksTabel.FindFirst();
                    NoEmpty := AlldeviceTasksLineTabel."CPC Quantity" <> 0;
                end;
            until (AlldeviceTasksTabel.Next(Random.DecimalInRange(10, 0)) = 0) or (AlldeviceTasksLineTabel.Count <> 0);

        Assert.IsTrue(NoEmpty, 'Field "CPC Quantity" Is Empty');
    end;

    [Test]
    procedure TestDontGetUsedSparesList()
    var
        AlldeviceTasks: Codeunit "CPC Alldevice Tasks";
        AlldeviceAPISetupPage: TestPage "CPC Alldevice API Setup";
        AlldeviceTasksLinesTabel: Record "CPC Alld. Service Task Lines";
        NumberRowsBeforeFunc: Integer;
        NumberRowsAfterFunc: Integer;
    begin
        AlldeviceAPISetupPage.OpenEdit();
        AlldeviceAPISetupPage."CPC Get Used Spares List Pref.".SetValue(Random.AlphabeticText(15));
        NumberRowsBeforeFunc := AlldeviceTasksLinesTabel.Count;
        asserterror AlldeviceTasks.GetUsedSparesList(AlldeviceTasksLinesTabel, Random.DecimalInRange(10, 0));
        NumberRowsAfterFunc := AlldeviceTasksLinesTabel.Count;

        Assert.IsTrue(NumberRowsAfterFunc = NumberRowsBeforeFunc, 'Rows inserted');
    end;
    
    var
        Assert: Codeunit "Library Assert";
        Random: Codeunit Any;
}