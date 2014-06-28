package quixada.ufc.br.controller;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.servlet.ModelAndView;

import quixada.ufc.br.enumerator.StatusProjeto;
import quixada.ufc.br.model.Documento;
import quixada.ufc.br.model.Parecer;
import quixada.ufc.br.model.Projeto;
import quixada.ufc.br.model.Usuario;
import quixada.ufc.br.service.GenericService;
import quixada.ufc.br.service.ProjetoService;

@Controller
public class ProjetoController {

	@Inject
	private GenericService<Projeto> serviceGeneric;
	
	@Inject
	private ProjetoService serviceProjeto;
	
	@Inject
	private GenericService<Usuario> serviceUsuario;
	
	@Inject
	private GenericService<Documento> serviceDocumento;
	
	@Inject
	private GenericService<Parecer> serviceParecer;

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)
			throws ServletException {
		binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		log.info("controller: projeto - action: index");
		return "index";
	}

	@RequestMapping(value = "cadastro", method = RequestMethod.GET)
	public String cadastro(Model model) {
		model.addAttribute("projeto", new Projeto());
		return "projeto/cadastro";
	}

	@RequestMapping(value = "novoProjeto", method = RequestMethod.POST)
	public String adicionarProjeto(
			@Valid @ModelAttribute("projeto") Projeto projeto,
			BindingResult result) {
		
		int tamanho = serviceProjeto.getMAXid();
		String codigo = stringFormatada(tamanho + 1);
		projeto.setCodigo(codigo );
		String resultado = projeto.getNome().trim();
		if (result.hasErrors() || resultado.isEmpty()) {
			return ("projeto/cadastro");
		}
		projeto.setStatus(StatusProjeto.NOVO);
		this.serviceGeneric.save(projeto);
		return "redirect:/listar";

	}

	@RequestMapping(value = "/{id}/informacoesProjeto")
	public String informacoes(Projeto p, @PathVariable("id") int id,
			Model model) {
		Projeto projeto = serviceGeneric.find(Projeto.class, id);
		model.addAttribute("projeto", projeto);
		return "projeto/informacoes";
	}
	
	
	
	@RequestMapping(value = "/{id}/editarProjeto")
	public String editar(Projeto p, @PathVariable("id") int id, Model model) {
		Projeto projeto = serviceGeneric.find(Projeto.class, id);
		System.out.println("Projeto do Banco antes de atualizar: "
				+ projeto.toString());
		model.addAttribute("projeto", projeto);
		return "projeto/editar";
	}

	
	@RequestMapping(value = "/{id}/editarProjetoForm", method = RequestMethod.POST)
	public String atualizarProjeto(@PathVariable("id") int id,
			@RequestParam(value="documentos", required = false) MultipartFile file,
			@ModelAttribute(value = "projeto") Projeto projetoAtualizado,
			BindingResult result) {
		
		String idDoc = projetoAtualizado.getNome() + file.getOriginalFilename();
		Documento documento = new Documento(idDoc, file.getOriginalFilename(), file.getContentType(), file);
		//PROBLEMA NESTA LINHA, NÂO CONSIGO SALVAR NO BANCO, ERRO DESCONHECIDO
		//serviceDocumento.save(documento);

		System.out.println("NOME DO ARQUIVO: " + documento.getNomeOriginal());

		projetoAtualizado.setStatus(StatusProjeto.NOVO);
		this.serviceGeneric.update(projetoAtualizado);
		System.out.println("Projeto do Banco DEPOIS de atualizar: "
				+ projetoAtualizado.toString());
		return "redirect:/listar";
	}

	@RequestMapping(value = "/{id}/excluirProjeto")
	public String excluirProjeto(Projeto p, @PathVariable("id") int id,
			Model model) {
		Projeto projeto = serviceGeneric.find(Projeto.class, id);
		if (projeto == null) {
			return "redirect:/listar";
		} else {
			this.serviceGeneric.delete(projeto);
			return "redirect:/listar";
		}
	}

	@RequestMapping(value = "{id}/submeterProjeto")
	public String submeterProjeto(@PathVariable("id") int id) {
		Projeto projeto = serviceGeneric.find(Projeto.class, id);
		if (validaSubmissao(projeto)) {
			projeto.setStatus(StatusProjeto.SUBMETIDO);
			this.serviceGeneric.update(projeto);
			System.out.println(projeto);
			return "redirect:/listar";
		} else {
			return "redirect:/" + id + "/editarProjeto";
		}
	}

	@RequestMapping(value = "/listar")
	public ModelAndView listar() {
		ModelAndView modelAndView = new ModelAndView("projeto/listar");
		List<Projeto> projeto = serviceGeneric.find(Projeto.class);
		modelAndView.addObject("projetos", projeto);
		return modelAndView;
	}
	
	@RequestMapping(value = "/listarDiretor")
	public ModelAndView listarDiretor() {
		ModelAndView modelAndView = new ModelAndView("diretor/listarDiretor");
		List<Projeto> projeto = serviceProjeto.projetosSubmetidos();
		modelAndView.addObject("projetos", projeto);
		return modelAndView;
	}

	private boolean validaSubmissao(Projeto projeto) {

		System.out.println("PROJETO:");
		if (!projeto.getNome().isEmpty() && !projeto.getLocal().isEmpty()
				&& !projeto.getParticipantes().isEmpty()
				&& projeto.getQuantidadeBolsa().intValue() > 0
				&& !projeto.getAtividades().isEmpty()
				&& !projeto.getDescricao().isEmpty()) {
			return true;
		} else {
			return false;
		}
	}
	

	private String stringFormatada(int contador){
		if(contador < 10){
			String codigo = "PESQ0"+ contador;
			return codigo;
		}else{
			String codigo = "PESQ"+ contador;
			return codigo;
		}
	}
	
	@RequestMapping(value = "{projetoId}/atribuirParecerista", method = RequestMethod.GET)
	public String atribuirParecerista(@PathVariable("projetoId") int projetoId, Model model) {
		
		Projeto projeto = serviceGeneric.find(Projeto.class, projetoId);
		
		if(projeto == null){
			model.addAttribute("error", "O projeto não existe!");
		}
		
		model.addAttribute("projetoId", projetoId);
		model.addAttribute("usuarios", serviceUsuario.find(Usuario.class));
		return "diretor/atribuirParecerista";
	}
	
	@RequestMapping(value = "atribuirParecerista", method = RequestMethod.GET)
	public String atribuirPareceristaNoProjeto(@RequestParam("parecerista") int parecerista, 
			@RequestParam("projetoId") int projetoId, @RequestParam("comentario_diretor") String comentario_diretor, 
			@RequestParam("prazo") Date prazo){ 
		
		Projeto projeto = serviceGeneric.find(Projeto.class, projetoId);
		Usuario usuario = serviceUsuario.find(Usuario.class, parecerista);
		Parecer parecer = new Parecer();
		
		parecer.setProjeto(projeto);
		parecer.setUsuario(usuario);
		parecer.setDataAtribuicao(new Date());
		parecer.setComentario(comentario_diretor);
		parecer.setPrazo(prazo);
		
		serviceParecer.save(parecer);
		projeto.setStatus(StatusProjeto.AGUARDANDO_PARECER);
		serviceGeneric.update(projeto);
		
		return "redirect:/listar";
	}

}
