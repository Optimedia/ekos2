package br.com.optimedia.autor.assets.img
{
	public class ImgAssets
	{
		[Embed('trashIcon.png')]
		public static const deleteIcon:Class;
		
		[Embed('editIcon.png')]
		public static const editIcon:Class;
		
		[Embed('minusIcon.png')]
		public static const publishedIcon:Class;
		
		[Embed('plusIcon.png')]
		public static const unpublishedIcon:Class;
		
        [Embed(source="Assets.swf",symbol="TreeFolderClosed")]
		public static const iconMinimised:Class;
		
	    [Embed(source="Assets.swf",symbol="TreeFolderOpen")]
		public static const iconMaximised:Class;
		
		
		//ÍCONES DA TREE DO REPOSITÓRIO
		[Embed('tableIcon.png')]
		public static const category1Icon:Class;
		
		[Embed('chartIcon.png')]
		public static const category2Icon:Class;
		
		[Embed('imageIcon.png')]
		public static const category3Icon:Class;
		
		[Embed('movieIcon.png')]
		public static const category4Icon:Class;
		
		[Embed('urlIcon.png')]
		public static const category5Icon:Class;
		
		[Embed('noteIcon.png')]
		public static const category6Icon:Class;
		
		[Embed('fileIcon.png')]
		public static const category7Icon:Class;
		
		
		//ÍCONES DA PREVIEW DO REPOSITÓRIO
		[Embed('movieIcon.png')]
		public static const movieIconLarge:Class;
		
		[Embed('fileIcon.png')]
		public static const fileIconLarge:Class;
		
	}
}