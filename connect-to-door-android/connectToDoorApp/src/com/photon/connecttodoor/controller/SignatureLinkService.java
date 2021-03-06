package com.photon.connecttodoor.controller;

import org.json.JSONException;
import org.json.JSONObject;

import com.photon.connecttodoor.utils.ApplicationConstant;

public class SignatureLinkService {
	/**
	 * @author fadli_m
	 * get signature image in kind of link
	 * @param employeeId
	 * @return
	 */
	public String handleSignatureLinkService (final String employeeId){
		final HttpAdapter httpAdapter = new HttpAdapter();
		String moduleSignature = ApplicationConstant.MODULE_SIGNATURE_LINK;
		String responseString = null;
		JSONObject response = null;
		JSONObject postBody = new JSONObject();
		try {	
			postBody.put("employee_id", employeeId);
			String postBodyString = postBody.toString();
			final String jsonString = httpAdapter.sendPostRequest(postBodyString, moduleSignature);
			response = new JSONObject(jsonString);
		}catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(response != null){
			responseString = response.toString();
		}
		return responseString;
	}
}
