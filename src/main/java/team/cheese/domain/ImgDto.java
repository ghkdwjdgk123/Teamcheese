package team.cheese.domain;

public class ImgDto {
    private Integer no;
    private Integer tb_no;
    private String tb_name;
    private String imgtype;
    private String file_rt;
    private String u_name;
    private String o_name;
    private String e_name;
    private int w_size;
    private int h_size;
    private String r_date;
    private String state;

    //판매꺼
    private Integer s_no;
    private String s_title;
    private Integer s_price;
    private String s_r_date;

    public ImgDto(){}

    //이미지 작성시 아래 사용
    public ImgDto(String tb_name, String imgtype, String file_rt, String u_name, String o_name, String e_name, int w_size, int h_size){
        this.tb_name = tb_name;
        this.imgtype = imgtype;
        this.file_rt = file_rt;
        this.u_name = u_name;
        this.o_name = o_name;
        this.e_name = e_name;
        this.w_size = w_size;
        this.h_size = h_size;
    }

    //

    @Override
    public String toString() {
        return "ImgDto{" +
                "no=" + no +
                ", tb_no=" + tb_no +
                ", tb_name='" + tb_name + '\'' +
                ", imgtype='" + imgtype + '\'' +
                ", filert='" + file_rt + '\'' +
                ", u_name='" + u_name + '\'' +
                ", o_name='" + o_name + '\'' +
                ", e_name='" + e_name + '\'' +
                ", w_size=" + w_size +
                ", h_size=" + h_size +
                ", r_date='" + r_date + '\'' +
                ", state='" + state + '\'' +
                ", s_no=" + s_no +
                ", s_title='" + s_title + '\'' +
                ", s_price=" + s_price +
                ", s_r_date='" + s_r_date + '\'' +
                '}';
    }

    public String getS_title() {
        return s_title;
    }

    public void setS_title(String s_title) {
        this.s_title = s_title;
    }

    public Integer getS_price() {
        return s_price;
    }

    public void setS_price(Integer s_price) {
        this.s_price = s_price;
    }

    public String getS_r_date() {
        return s_r_date;
    }

    public void setS_r_date(String s_r_date) {
        this.s_r_date = s_r_date;
    }

    public Integer getS_no() {
        return s_no;
    }

    public void setS_no(Integer s_no) {
        this.s_no = s_no;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getTb_name() {
        return tb_name;
    }

    public void setTb_name(String tb_name) {
        this.tb_name = tb_name;
    }

    public String getFilert() {
        return file_rt;
    }

    public void setFilert(String file_rt) {
        this.file_rt = file_rt;
    }

    public String getU_name() {
        return u_name;
    }

    public void setU_name(String u_name) {
        this.u_name = u_name;
    }

    public String getO_name() {
        return o_name;
    }

    public void setO_name(String o_name) {
        this.o_name = o_name;
    }

    public String getE_name() {
        return e_name;
    }

    public void setE_name(String e_name) {
        this.e_name = e_name;
    }

    public int getW_size() {
        return w_size;
    }

    public void setW_size(int w_size) {
        this.w_size = w_size;
    }

    public int getH_size() {
        return h_size;
    }

    public void setH_size(int h_size) {
        this.h_size = h_size;
    }

    public String getR_date() {
        return r_date;
    }

    public void setR_date(String r_date) {
        this.r_date = r_date;
    }

    public Integer getTb_no() {
        return tb_no;
    }

    public void setTb_no(Integer tb_no) {
        this.tb_no = tb_no;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getImgtype() {
        return imgtype;
    }

    public void setImgtype(String imgtype) {
        this.imgtype = imgtype;
    }
}
