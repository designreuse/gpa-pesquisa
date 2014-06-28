package quixada.ufc.br.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.Type;
import org.springframework.web.multipart.MultipartFile;

@Entity
public class Documento {

	@Id
	private String id;
	
	private String nomeOriginal;
	
	private String prefixo;
	
	private String tipo;
	
	@Type(type="org.hibernate.type.BinaryType") 
	private MultipartFile arquivo;

	@ManyToOne
	@JoinColumn(name = "projeto_id")
	private Projeto projeto;
	
	public Documento(){
		super();
	}	
	
	public Documento(String id, String nomeOriginal, String prefixo, String tipo, MultipartFile arquivo) {
		super();
		this.id = id;
		this.nomeOriginal = nomeOriginal;
		this.prefixo = prefixo;
		this.tipo = tipo;
		this.arquivo = arquivo;	
	}
	
	public Documento(String id, String nomeOriginal, String tipo, MultipartFile arquivo){
		super();
		this.id = id;
		this.nomeOriginal = nomeOriginal;
		this.tipo = tipo;
		this.arquivo = arquivo;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNomeOriginal() {
		return nomeOriginal;
	}

	public void setNomeOriginal(String nomeOriginal) {
		this.nomeOriginal = nomeOriginal;
	}

	public String getPrefixo() {
		return prefixo;
	}

	public void setPrefixo(String prefixo) {
		this.prefixo = prefixo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public MultipartFile getArquivo() {
		return arquivo;
	}

	public void setArquivo(MultipartFile arquivo) {
		this.arquivo = arquivo;
	}
	
	
	
}

