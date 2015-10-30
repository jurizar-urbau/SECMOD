package com.urbau.misc;

public class Constants {
	
	public static final String[] MESES ={"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};
	
	public static final int ITEMS_PER_PAGE = 20;	
	public static final int OPTIONS_ADD = 1;
	public static final int OPTIONS_MODIFY = 2;
	public static final int OPTIONS_DELETE = 3;
	public static final int OPTIONS_VIEW = 4;
	public static final int OPTIONS_File = 5;
	public static final int OPTIONS_DETAIL = 6;
	
	public static final String ACCOUNTS_ADDS = "H";
	public static final String ACCOUNTS_SUBSTRACT = "D";
	public static final String ACCOUNTS_ADDS_SUBSTRACT = "DH";
	
	public static final String ESTADO_INGRESADO = "I";
	public static final String ESTADO_CANCELADO = "C";
	public static final String ESTADO_DESPACHADO = "D";
	
	public static final String ADD ="add";
	public static final String REMOVE = "remove";
	public static final String EDIT = "edit";	
	public static final String TRUE_STRING = "true";
	
	// feeders
	public static final String NAME_PROGRAMS = "com.urbau.feeders.ProgramsMain";
	public static final String NAME_ROLS = "com.urbau.feeders.RolesMain";
	public static final String NAME_USUARIOS = "com.urbau.feeders.UsuariosMain";
	public static final String NAME_OPTIONS = "com.urbau.feeders.OptionsMain";
	public static final String NAME_ALIAS = "com.urbau.feeders.AliasMain";
	public static final String NAME_PACKING = "com.urbau.feeders.PackingMain";
	public static final String NAME_OPTIONS_BY_PROGRAM = "com.urbau.feeders.OptionsByProgramMain";
	public static final String NAME_FILES_TYPES = "com.urbau.feeders.FilesTypeMain";
	public static final String NAME_ACCOUNTS = "com.urbau.feeders.CuentasMain";
	public static final String NAME_CASHBOX = "com.urbau.feeders.CajaMain";
	public static final String NAME_MONEDAS = "com.urbau.feeders.MonedasMain";
	public static final String NAME_PAISES = "com.urbau.feeders.PaisesMain";
	public static final String NAME_PROVEEDORES = "com.urbau.feeders.ProveedoresMain";
	public static final String NAME_PRODUCTOS = "com.urbau.feeders.ProductosMain";
	public static final String NAME_BODEGAS = "com.urbau.feeders.BodegasMain";
	public static final String NAME_PRECIOS = "com.urbau.feeders.PreciosMain";
	public static final String NAME_TIPOSDEMOVIMIENTOS = "com.urbau.feeders.TiposDeMovimientosMain";
	public static final String NAME_BANCOSMOVIMIENTOS = "com.urbau.feeders.BancosMovimientosMain";
	public static final String NAME_TIPOSRUBROS = "com.urbau.feeders.TiposRubrosMain";
	public static final String NAME_CLASIFICACIONRUBROS = "com.urbau.feeders.ClasificacionRubrosMain";
	public static final String NAME_PRESUPUESTO	 = "com.urbau.feeders.PresupuestoMain";
	public static final String NAME_PRESUPUESTOS_PROYECCIONES	 = "com.urbau.feeders.PresupuestosProyeccionesMain";
	public static final String NAME_PRESUPUESTOS_EJECUCIONES	 = "com.urbau.feeders.PresupuestosEjecucionesMain";
		
	//parameters
	public static final String Q_PARAMETER = "q";
	public static final String ID_PARAMETER = "id";
	public static final String MODE_PARAMETER = "mode";	
	public static final String ROL_NAME_PARAMETER = "rolname";
	public static final String NAME_PARAMETER = "name";	
	public static final String DESCRIPCION_PARAMETER = "descripcion";
	public static final String SYMBOL_PARAMETER = "symbol";
	public static final String ID_PROGRAM_PARAMETER = "idProgram";
	public static final String ID_OPTION_PARAMETER = "idOption";
	public static final String ID_ROL_PARAMETER = "idRol";
	public static final String CLIENT_ID_PARAMETER = "clientid";
	public static final String BODEGA_ID_PARAMETER = "bodegaid";
	public static final String PRODUCT_ID_PARAMETER = "productid";
	public static final String AMOUNT_PARAMETER = "amount";
	public static final String PRICE_PARAMETER = "price";
	public static final String COIN_PARAMETER = "coin";
	
	public static final String NOMBRE_PARAMETER="nombre";
	public static final String DIRRECCION_PARAMETER="dirreccion";
	public static final String TELEFONO_PARAMETER="telefono";
	public static final String PRINCIPAL_PARAMETER="principal";
	public static final String CLIENTE_PARAMETER = "cliente";
	public static final String BODEGA_PARAMETER = "bodega";
	public static final String USUARIO_PARAMETER = "usuario";
	public static final String MODAL_PARAMETER = "modal";
	public static final String ID_BODEGA_BORRAR_PARAMETER = "idBodegaBorrar";
	public static final String ANIO_PARAMETER = "anio";
	public static final String MES_PARAMETER = "mes";
	public static final String TIPO_RUBRO_PARAMETER ="tiporubro";
	public static final String MONTO_PARAMETER = "monto";
	public static final String RUBRO_PARAMETER = "rubro";
	public static final String ID_PRODUCTO_PARAMETER = "idproducto";	
	public static final String PROGRAM_DESCRIPTION_PARAMETER = "programdesc";
	public static final String PROGRAM_NAME_PARAMETER = "programname";
	public static final String NIT_PARAMETER = "nit";
	public static final String NOMBRES_PARAMETER = "nombres";
	public static final String APELLIDOS_PARAMETER = "apellidos";
	public static final String CORREO_PARAMETER = "correo";
	public static final String TIPO_DE_CLIENTE_PARAMETER = "tipodecliente";
	public static final String PACKAGE_NAME_PARAMETER = "packageName";
	public static final String PRODUCTO_PARAMETER = "producto";
	public static final String ESTATUS_PARAMETER = "estatus";
	public static final String CANTIDAD_PARAMETER = "cantidad";
	public static final String ESTATUS_REMOVE_PARAMETER = "estatusremove";
	public static final String COEFICIENTE_PARAMETER = "coeficiente";
	public static final String PRECIO_PARAMETER = "precio";
	public static final String PRECIO_1_PARAMETER = "precio_1";
	public static final String PRECIO_2_PARAMETER = "precio_2";
	public static final String PRECIO_3_PARAMETER = "precio_3";
	public static final String PRECIO_4_PARAMETER = "precio_4";
	public static final String IMAGE_PATH_PARAMETER = "imagePath";	
	public static final String STOCK_MINIMO_PARAMETER = "stock_minimo";	
	public static final String ID_PRECIO_BORRAR_PARAMETER = "idPrecioBorrar";
	public static final String PUNTO_DE_VENTA_PARAMETER = "puntoDeVenta";
	public static final String PRESUPUESTO_PARAMETER = "presupuesto";
	public static final String COEFICIENTE_UNIDAD_PARAMETER = "coeficiente_unidad";
	public static final String CODIGO_PARAMETER = "codigo";
	public static final String PROVEEDOR_PARAMETER = "proveedor";
	public static final String RAZON_SOCIAL_PARAMETER = "razonsocial";
	public static final String CONTACTO_PARAMETER = "contacto";
	public static final String DIRECCION_PARAMETER = "direccion";
	public static final String PAIS_PARAMETER = "pais";
	public static final String LIMITE_CREDITO_PARAMETER = "limitecredito";
	public static final String SALDO_PARAMETER = "saldo";
	public static final String BANCO_PARAMETER = "banco";
	public static final String FECHA_PARAMETER = "fecha";
	public static final String TIPO_MOVIMIENTO_PARAMETER = "tipomovimiento";
	public static final String LOGIN_ID_PARAMETER = "loginid";
	public static final String NOMBRES_APELLIDOS_PARAMETER = "nombresapellidos";
	public static final String CLAVE_PARAMETER = "clave";
	public static final String EMAIL_PARAMETER = "email";
	public static final String ACTIVO_PARAMETER = "activo";
	public static final String ROL_PARAMETER = "rol";	

}

