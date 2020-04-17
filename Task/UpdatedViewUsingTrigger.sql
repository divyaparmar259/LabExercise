select * from Brands
select * from BrandStatus
select * from vBrandUpdate

alter Trigger updateDataTrigg
on vBrandUpdate
INSTEAD OF UPDATE 
AS
Begin
	SET NOCOUNT ON;
	declare @BrandId int;
	declare @BrandName varchar(30);
	declare @Status varchar(30);
select  @BrandId=BrandId, @BrandName=BrandName,@Status=Status from inserted;
update  vBrandUpdate set BrandName=@BrandName from inserted where inserted.BrandId=@BrandId
update  vBrandUpdate set Status=@Status from inserted where inserted.BrandId=@BrandId
end

update vBrandUpdate set BrandName='A', Status = 'approved' where BrandId=3

drop trigger updateDataTrigg