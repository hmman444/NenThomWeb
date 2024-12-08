package entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Pet")
public class Pet {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "petCode", nullable = false, length = 50)
	private String petCode;

	@Column(name = "petName", nullable = false, length = 100)
	private String petName;

	@Column(name = "age", nullable = false)
	private int age;

	@Column(name = "careTask", length = 255)
	private String careTask;

	@Column(name = "notes")
	private String notes;

	// Getters và Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPetCode() {
		return petCode;
	}

	public void setPetCode(String petCode) {
		this.petCode = petCode;
	}

	public String getPetName() {
		return petName;
	}

	public void setPetName(String petName) {
		this.petName = petName;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getCareTask() {
		return careTask;
	}

	public void setCareTask(String careTask) {
		this.careTask = careTask;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
}
