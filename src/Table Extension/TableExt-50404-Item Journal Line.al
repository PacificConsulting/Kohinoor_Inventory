tableextension 50404 ItemJnlLineExt extends "Item Journal Line"
{
    fields
    {
        field(50401; "Sr. No. Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}