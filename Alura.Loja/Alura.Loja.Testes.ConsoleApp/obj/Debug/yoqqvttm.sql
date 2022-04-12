IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Produtos] (
    [Id] int NOT NULL IDENTITY,
    [Categoria] nvarchar(max),
    [Nome] nvarchar(max),
    [Preco] float NOT NULL,
    CONSTRAINT [PK_Produtos] PRIMARY KEY ([Id])
);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220411184257_Inicial', N'1.1.2');

GO

EXEC sp_rename N'Produtos.Preco', N'PrecoUnitario', N'COLUMN';

GO

ALTER TABLE [Produtos] ADD [Unidade] nvarchar(max);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220411184516_Unidade', N'1.1.2');

GO

CREATE TABLE [Compras] (
    [Id] int NOT NULL IDENTITY,
    [Preco] float NOT NULL,
    [ProdutoId] int NOT NULL,
    [Quantidade] int NOT NULL,
    CONSTRAINT [PK_Compras] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Compras_Produtos_ProdutoId] FOREIGN KEY ([ProdutoId]) REFERENCES [Produtos] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_Compras_ProdutoId] ON [Compras] ([ProdutoId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220411191923_Compra', N'1.1.2');

GO

