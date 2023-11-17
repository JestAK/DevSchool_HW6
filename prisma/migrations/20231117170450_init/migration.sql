-- CreateEnum
CREATE TYPE "Role" AS ENUM ('GUEST', 'ADMIN', 'PUBLISHER');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'GUEST',

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Content" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "amountOfSeasons" INTEGER DEFAULT 1,
    "amountOfEpisodes" INTEGER NOT NULL,

    CONSTRAINT "Content_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Genre" (
    "id" TEXT NOT NULL,
    "genreName" TEXT NOT NULL,

    CONSTRAINT "Genre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Studio" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Studio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UpdateSubscription" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "isSubscribed" BOOLEAN DEFAULT true,

    CONSTRAINT "UpdateSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ContentToStudio" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ContentToGenre" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ContentToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Content_title_key" ON "Content"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Genre_genreName_key" ON "Genre"("genreName");

-- CreateIndex
CREATE UNIQUE INDEX "UpdateSubscription_email_key" ON "UpdateSubscription"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UpdateSubscription_userId_key" ON "UpdateSubscription"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_ContentToStudio_AB_unique" ON "_ContentToStudio"("A", "B");

-- CreateIndex
CREATE INDEX "_ContentToStudio_B_index" ON "_ContentToStudio"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ContentToGenre_AB_unique" ON "_ContentToGenre"("A", "B");

-- CreateIndex
CREATE INDEX "_ContentToGenre_B_index" ON "_ContentToGenre"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ContentToUser_AB_unique" ON "_ContentToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ContentToUser_B_index" ON "_ContentToUser"("B");

-- AddForeignKey
ALTER TABLE "UpdateSubscription" ADD CONSTRAINT "UpdateSubscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToStudio" ADD CONSTRAINT "_ContentToStudio_A_fkey" FOREIGN KEY ("A") REFERENCES "Content"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToStudio" ADD CONSTRAINT "_ContentToStudio_B_fkey" FOREIGN KEY ("B") REFERENCES "Studio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToGenre" ADD CONSTRAINT "_ContentToGenre_A_fkey" FOREIGN KEY ("A") REFERENCES "Content"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToGenre" ADD CONSTRAINT "_ContentToGenre_B_fkey" FOREIGN KEY ("B") REFERENCES "Genre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToUser" ADD CONSTRAINT "_ContentToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Content"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ContentToUser" ADD CONSTRAINT "_ContentToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
