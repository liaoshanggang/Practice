package com.ch8.test8_15duotaiup;


/**�����Ϊ��
 * ��1�������ǽγ����ǿ���������������װ60�����ͣ�ÿ�θ������ͣ���������20����
 * �������20��������������ʱ����ӵ�60�����ɣ����ڿ���̨����������Ѽ�������
 * ��2��������ʻ1�Σ�����5�������������10�������������10������������ʻ��ֱ���ڿ���̨�������������10������Ҫ���ͣ���
 *
 */
public class TestRentChe5 {
	public static void main(String[] args) {
		Car car = new Car("ս��","����");//��ʼ���γ�����car
		Truck truck = new Truck("����ʿ����","10��");//��ʼ����������truck
		Driver d1 = new Driver("������");//��������ʼ����ʻԱ����
		//ʵ�ʴ�����������������ִ�е������������д��show()����
		d1.callShow(car);//���ü�ʻԱ�������Ӧ����
		d1.callShow(truck);//���ü�ʻԱ�������Ӧ����
	}
}