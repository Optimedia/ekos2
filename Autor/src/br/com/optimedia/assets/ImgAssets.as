package br.com.optimedia.assets
{
	public class ImgAssets
	{
		[Embed('img/trashIcon.png')]
		public static const deleteIcon:Class;
		
		[Embed('img/editIcon.png')]
		public static const editIcon:Class;
		
		[Embed('img/minusIcon.png')]
		public static const publishedIcon:Class;
		
		[Embed('img/plusIcon.png')]
		public static const unpublishedIcon:Class;
		
        [Embed(source="Assets.swf",symbol="TreeFolderClosed")]
		public static const iconMinimised:Class;
		
	    [Embed(source="Assets.swf",symbol="TreeFolderOpen")]
		public static const iconMaximised:Class;
		
		
		//ÍCONES DA TREE DO REPOSITÓRIO
		[Embed('img/tableIcon.png')]
		public static const category1Icon:Class;
		
		[Embed('img/chartIcon.png')]
		public static const category2Icon:Class;
		
		[Embed('img/imageIcon.png')]
		public static const category3Icon:Class;
		
		[Embed('img/movieIcon.png')]
		public static const category4Icon:Class;
		
		[Embed('img/urlIcon.png')]
		public static const category5Icon:Class;
		
		[Embed('img/noteIcon.png')]
		public static const category6Icon:Class;
		
		[Embed('img/fileIcon.png')]
		public static const category7Icon:Class;
		
		
		//ÍCONES DA PREVIEW DO REPOSITÓRIO
		[Embed('img/movieIconLarge.png')]
		public static const movieIconLarge:Class;
		
		[Embed('img/fileIconLarge.png')]
		public static const fileIconLarge:Class;
		
		
		//IMGS DO PLAYER
		[Embed(source="img/playerSkin.swf",symbol="taskbar")]
		public static const playerTaskbar:Class;
	}
}