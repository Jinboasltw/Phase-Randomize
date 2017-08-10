function [ signal_surrogate, faxis, PS ] = randphase( signal,samplerate, method)
%�������źŽ�����λ���֮����������ʱ����
%   input : ԭʼ�ź�
% process : fft ת����Ƶ��; angle ��鵱ǰ��λ; ���������λ;д����λ;ifftת��ʱ��
% output : ����ź�
% Get parameters
[n_time, n_frame] = size(signal);
if n_frame > n_time
    temp = n_frame;
    n_frame = n_time;
    n_time = temp;
    signal = signal';
end
% ���FFT����Գ�������
[ fixfft_signal, nfft, faxis, PS ] = fixfft( signal, n_time,samplerate, method );
signal_surrogate = zeros(n_time,n_frame);
rand_phase = rand([nfft, 1])*2*pi;
rand_phase_matrix = repmat(exp( 2*pi*1i*rand_phase),1,n_frame);
signal_surrogate_matrix = fixfft_signal .* rand_phase_matrix;
for k = 1:n_frame
    signal_surrogate(:,:,k)= real(ifft(signal_surrogate_matrix(:,k), n_time))';
end
end

