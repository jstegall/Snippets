USE [TestFTIEnterprise]
GO

CREATE FUNCTION dbo.splitString
 (@Input NVARCHAR(MAX),
  @Delimiter NVARCHAR(20))
RETURNS @Tokens TABLE(Token NVARCHAR(MAX))
BEGIN
  DECLARE @String NVARCHAR(MAX)

  WHILE (CHARINDEX(@Delimiter, @Input, 0) <> 0)
  BEGIN
    SELECT @String = RTRIM(LTRIM(SUBSTRING(@Input, 1, CHARINDEX(@Delimiter, @Input, 0) - 1))),
      @Input = RTRIM(LTRIM(SUBSTRING(@Input, CHARINDEX(@Delimiter, @Input, 0) + LEN(@Delimiter), LEN(@Input))))

    IF (LEN(@String) > 0)
    BEGIN
      INSERT INTO @Tokens
      SELECT @String
    END
  END

  IF (LEN(@Input) > 0)
  BEGIN
    INSERT INTO @Tokens
    SELECT @Input
  END

  RETURN
END
GO