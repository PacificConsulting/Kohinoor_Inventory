codeunit 50401 "Events Subscribers"
{
    trigger OnRun()
    begin

    end;
    //<<<<<START********************************PAGE-6510*****************************************
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnAfterCreateReservEntry(var ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification"; OldTrackingSpecification: Record "Tracking Specification"; CurrentRunMode: Enum "Item Tracking Run Mode"; CurrentSourceType: Integer; TempReservEntry: Record "Reservation Entry");
    begin
        ReservEntry."Sr. No. Posting Date" := OldTrackingSpecification."Sr. No. Posting Date";
        ReservEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification");
    begin
        DestTrkgSpec."Sr. No. Posting Date" := SourceTrackingSpec."Sr. No. Posting Date";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean);
    begin
        IdenticalArray[2] := IdenticalArray[2] And (ReservEntry1."Sr. No. Posting Date" = ReservEntry2."Sr. No. Posting Date")
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry");
    begin
        ReservEntry."Sr. No. Posting Date" := TrkgSpec."Sr. No. Posting Date";
    end;
    //<<<<<END********************************PAGE-6510*****************************************

    //<<<<<<<START********************************CU-22*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification"; var TempItemJournalLine: Record "Item Journal Line"; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal);
    begin
        TempItemJournalLine."Sr. No. Posting Date" := TempTrackingSpecification."Sr. No. Posting Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; var ItemLedgEntry: Record "Item Ledger Entry");
    begin
        ValueEntry."Sr. No. Posting Date" := ItemLedgEntry."Sr. No. Posting Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    var
        RecItem: Record 27;
    begin
        NewItemLedgEntry."Sr. No. Posting Date" := ItemJournalLine."Sr. No. Posting Date";

    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', false, false)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemtrckMgt: Codeunit "Item Tracking Management";
        TrackSpec: Record "Tracking Specification" temporary;
        SerialNoInfo: Record "Serial No. Information";
    begin
        if ItemJournalLine."Serial No." <> '' then begin
            if not SerialNoInfo.Get(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Serial No.") then begin
                SerialNoInfo.Init();
                SerialNoInfo.Validate("Item No.", ItemJournalLine."Item No.");
                SerialNoInfo.Validate("Variant Code", ItemJournalLine."Variant Code");
                SerialNoInfo.Validate("Serial No.", ItemJournalLine."Serial No.");
                SerialNoInfo.Insert(true);
            end;
            Message('Item No. %1 and Serial No. %1 combination serial No. card already Created');
            // IF Not Confirm('Item No. %1 and Serial No. %1 combination serial No. card already Created, Do you wnat to create Agin same as duplicate', true) then
            //     exit;

        end;
        //ItemtrckMgt.CreateSerialNoInformation();
    end;
    //<<<<<<<END********************************CU-22*****************************************

    var
        myInt: Integer;
}