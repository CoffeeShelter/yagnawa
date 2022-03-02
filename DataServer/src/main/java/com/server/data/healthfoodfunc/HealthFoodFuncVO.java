package com.server.data.healthfoodfunc;

public class HealthFoodFuncVO {
	private String prdlst_cd;
	private String pc_kor_nm;
	private String testitm_cd;
	private String t_kor_nm;
	private String fnprt_itm_nm;
	private String spec_val;
	private String spec_val_sumup;
	private String vald_begn_dt;
	private String vald_end_dt;
	private String sorc;
	private String mxmm_val;
	private String nimm_val;
	private String injry_yn;
	private String unit_nm;

	public String getPrdlst_cd() {
		return prdlst_cd;
	}

	public void setPrdlst_cd(String prdlst_cd) {
		this.prdlst_cd = prdlst_cd;
	}

	public String getPc_kor_nm() {
		return pc_kor_nm;
	}

	public void setPc_kor_nm(String pc_kor_nm) {
		this.pc_kor_nm = pc_kor_nm;
	}

	public String getTestitm_cd() {
		return testitm_cd;
	}

	public void setTestitm_cd(String testitm_cd) {
		this.testitm_cd = testitm_cd;
	}

	public String getT_kor_nm() {
		return t_kor_nm;
	}

	public void setT_kor_nm(String t_kor_nm) {
		this.t_kor_nm = t_kor_nm;
	}

	public String getFnprt_itm_nm() {
		return fnprt_itm_nm;
	}

	public void setFnprt_itm_nm(String fnprt_itm_nm) {
		this.fnprt_itm_nm = fnprt_itm_nm;
	}

	public String getSpec_val() {
		return spec_val;
	}

	public void setSpec_val(String spec_val) {
		this.spec_val = spec_val;
	}

	public String getSpec_val_sumup() {
		return spec_val_sumup;
	}

	public void setSpec_val_sumup(String spec_val_sumup) {
		this.spec_val_sumup = spec_val_sumup;
	}

	public String getVald_begn_dt() {
		return vald_begn_dt;
	}

	public void setVald_begn_dt(String vald_begn_dt) {
		this.vald_begn_dt = vald_begn_dt;
	}

	public String getVald_end_dt() {
		return vald_end_dt;
	}

	public void setVald_end_dt(String vald_end_dt) {
		this.vald_end_dt = vald_end_dt;
	}

	public String getSorc() {
		return sorc;
	}

	public void setSorc(String sorc) {
		this.sorc = sorc;
	}

	public String getMxmm_val() {
		return mxmm_val;
	}

	public void setMxmm_val(String mxmm_val) {
		this.mxmm_val = mxmm_val;
	}

	public String getNimm_val() {
		return nimm_val;
	}

	public void setNimm_val(String nimm_val) {
		this.nimm_val = nimm_val;
	}

	public String getInjry_yn() {
		return injry_yn;
	}

	public void setInjry_yn(String injry_yn) {
		this.injry_yn = injry_yn;
	}

	public String getUnit_nm() {
		return unit_nm;
	}

	public void setUnit_nm(String unit_nm) {
		this.unit_nm = unit_nm;
	}

	@Override
	public String toString() {
		return "HealthFoodFuncVO [prdlst_cd=" + prdlst_cd + ", pc_kor_nm=" + pc_kor_nm + ", testitm_cd=" + testitm_cd
				+ ", t_kor_nm=" + t_kor_nm + ", fnprt_itm_nm=" + fnprt_itm_nm + ", spec_val=" + spec_val
				+ ", spec_val_sumup=" + spec_val_sumup + ", vald_begn_dt=" + vald_begn_dt + ", vald_end_dt="
				+ vald_end_dt + ", sorc=" + sorc + ", mxmm_val=" + mxmm_val + ", nimm_val=" + nimm_val + ", injry_yn="
				+ injry_yn + ", unit_nm=" + unit_nm + "]";
	}

}
