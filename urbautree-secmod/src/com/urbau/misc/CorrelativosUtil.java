package com.urbau.misc;

import java.util.ArrayList;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;

public class CorrelativosUtil {

	
	public synchronized int getNextAndAdvance( String key ){
		int correlativo = -1;
		ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "CORRELATIVOS", 
				new String[]{"DESCRIPCION","CORRELATIVO"},
					new int[]{ 
					Constants.EXTENDED_TYPE_STRING, 
					Constants.EXTENDED_TYPE_INTEGER
				} );
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(
				new String[]{ "DESCRIPCION" }, 
				new int[]{ ExtendedFieldsFilter.EQUALS}, 
				new int[]{ Constants.EXTENDED_TYPE_STRING }, 
				new String[]{ key} 
				);
		ArrayList<ExtendedFieldsBean> beans = um.getAll(filter);
		
		if( beans.size() > 0 ){
			ExtendedFieldsBean bean = beans.get( 0 );
			correlativo = bean.getValueAsInt( "CORRELATIVO" );
			correlativo++;
			bean.putValue( "CORRELATIVO", String.valueOf( correlativo ));
			if ( um.mod(bean) ){
				return correlativo;
			};
		} else {
			correlativo = 1; 
			ExtendedFieldsBean bean = new ExtendedFieldsBean();
			bean.putValue("DESCRIPCION",  key );
			bean.putValue( "CORRELATIVO", String.valueOf( correlativo ) );
			if( um.add( bean ) ){
				return correlativo;
			}
		}
		return correlativo;
	}
	
	
}
